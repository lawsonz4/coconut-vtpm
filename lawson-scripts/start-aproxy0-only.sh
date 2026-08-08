#!/bin/bash

unset http_proxy
unset https_proxy
unset all_proxy
echo "http_proxy 已清空"
echo "https_proxy 已清空"
echo "all_proxy 已清空"

SCRIPT_PATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
source "${SCRIPT_PATH}/cvm0.conf"
svsm/bin/aproxy --protocol "trustee" --unix "${PROXY_SOCK}" --url "${KBS_URL}" --force
