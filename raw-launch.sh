#!/bin/bash
source file.env
OVMF_FLASH_LINE="-drive if=pflash,format=raw,unit=0,file=OVMF_CODE.fd,readonly=on"
OVMF_DIRECT_LINE="-bios /home/lawson/data/root/sev-CCC/snp-svsm-vtpm/edk2/Build/OvmfX64/DEBUG_GCC/FV/OVMF.fd"

IGVM_LINE="-machine igvm-cfg=igvm0 -object igvm-cfg,id=igvm0,file=$IGVM_FILE"
#GRAPHIC_LINE="-vga std -vnc :0"
GRAPHIC_LINE="-serial stdio"
SNP_LINE="-machine confidential-guest-support=sev0,vmport=off -object sev-snp-guest,id=sev0,policy=0x30000,cbitpos=51,reduced-phys-bits=1"

set -x
#QEMU="/home/lawson/data/root/sev-CCC/AMDSEV/qemu/build/qemu-system-x86_64"
QEMU="/home/lawson/data/root/sev-CCC/coconut-vtpm/qemu/build/qemu-system-x86_64"
${QEMU} \
    -enable-kvm \
    -cpu EPYC-v3,+la57,phys-bits=48 \
    -smp 4,maxcpus=48 \
    -m 2048M,slots=5,maxmem=10240M \
    -machine q35 \
    -no-reboot \
    ${GRAPHIC_LINE} \
    -cdrom ${ISO_FILE} \
    -boot d \
    -device virtio-scsi-pci,id=scsi0,disable-legacy=on,iommu_platform=true \
    -drive file=${HDA},if=none,id=disk0,format=qcow2 \
    -device scsi-hd,drive=disk0 \
    ${SNP_LINE} \
    ${IGVM_LINE} \
    -kernel ${KERNEL_FILE} \
    -append "console=ttyS0 earlyprintk=serial root=/dev/sda2" \
    -initrd ${INITRD_FILE} \
    -monitor pty \
    -monitor unix:monitor,server,nowait
