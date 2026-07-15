#!/bin/bash


unset http_proxy
unset https_proxy
SCRIPT_PATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
source "${SCRIPT_PATH}/cvm0.conf"
svsm/bin/aproxy --protocol "trustee" --unix "${PROXY_SOCK}" --url "${KBS_URL}" --force
