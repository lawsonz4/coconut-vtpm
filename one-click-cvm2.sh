timeout 3s /home/lawson/data/root/sev-CCC/coconut-vtpm/lawson-scripts/reset-system2.sh || true
/home/lawson/data/root/sev-CCC/coconut-vtpm/lawson-scripts/start-aproxy2-only.sh &
/home/lawson/data/root/sev-CCC/coconut-vtpm/launch-cvm2.sh
