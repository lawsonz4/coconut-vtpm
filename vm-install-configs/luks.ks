rootpw --plaintext root
firstboot --disable
timezone America/New_York --utc
keyboard --vckeymap=us --xlayouts='us'
lang en_US.UTF-8
reboot
text
skipx

ignoredisk --only-use=vda
clearpart --all --initlabel --disklabel=gpt --drives=vda
part /boot/efi --size=512 --fstype=efi
part /boot --size=1024 --fstype=xfs --label=boot
part / --fstype="xfs" --ondisk=vda --encrypted --label=root --luks-version=luks2 --grow --passphrase "MY-LUKS-PASSPHRASE"
bootloader --append="console=ttyS0"

%packages
@^server-product-environment
%end

%post
# Set GPT parition type UUID for the root parition
parted --script /dev/vda type 3 4f68bce3-e8cd-4db1-96e7-fbcaf984b709
dnf install -y tpm2-tools
# We need an updated kernel for SVSM vTPM driver (6.16) and UEFI var (6.17)
dnf upgrade -y kernel
# use tpm to unlock the disk
cp /etc/crypttab /etc/crypttab.orig
cat /etc/crypttab.orig | awk '{print $1" "$2" - tpm2-device=auto,discard"}' | tee /etc/crypttab
# Put "tpm" driver in the initrd
echo 'add_drivers+=" tpm tpm_svsm "' > /etc/dracut.conf.d/99-tpm.conf
# Trigger initrd rebuild
dracut --regenerate-all --force
%end
