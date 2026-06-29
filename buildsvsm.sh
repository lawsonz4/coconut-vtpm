#!/bin/bash

SCRIPT_PATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

CLEAN=0

function usage
{
    echo -e "usage: $0 [OPTION...]"
    echo -e ""
    echo -e "Initialize git submodules and build QEMU, EDK2, SVSM, etc."
    echo -e ""
    echo -e "     --no-varstore   Disable the SVSM-based UEFI varaible store (experimental)"
    echo -e " -c, --clean         clean all previous artifacts"
    echo -e " -h, --help          print this help"
}

OPT_VARSTORE=1

while [ "$1" != "" ]; do
    case $1 in
      --no-varstore)
            OPT_VARSTORE=0
            ;;
        -c | --clean )
            CLEAN=1
            ;;
        -h | --help )
            usage
            exit
            ;;
        * )
            echo -e "\nParameter not found: $1\n"
            usage
            exit 1
    esac
    shift
done

set -ex
pushd "${SCRIPT_PATH}/svsm"
git submodule sync
git submodule update --init
make utils/cbit aproxy
SVSM_FEATURES="vtpm,attest,virtio-drivers"
if [[ $OPT_VARSTORE -eq 1 ]]; then
  SVSM_FEATURES+=",uefivars,secureboot"
fi
{
  set -x
  FW_FILE=${SCRIPT_PATH}/edk2/Build/OvmfX64/DEBUG_GCC/FV/OVMF.fd FEATURES=$SVSM_FEATURES make
}
popd
