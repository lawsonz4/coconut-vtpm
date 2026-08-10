unset http_proxy
unset https_proxy
unset all_proxy
echo "http_proxy 已清空"
echo "https_proxy 已清空"
echo "all_proxy 已清空"

timeout 3s /home/lawson/data/root/sev-CCC/coconut-vtpm/lawson-scripts/reset-system2.sh || true
/home/lawson/data/root/sev-CCC/coconut-vtpm/lawson-scripts/start-aproxy2-only.sh &
/home/lawson/data/root/sev-CCC/coconut-vtpm/launch-cvm2.sh
