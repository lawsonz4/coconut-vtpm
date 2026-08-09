timeout 3s /home/lawson/data/root/sev-CCC/coconut-vtpm/lawson-scripts/reset-system0.sh || true
/home/lawson/data/root/sev-CCC/coconut-vtpm/lawson-scripts/start-aproxy0-only.sh &
/home/lawson/data/root/sev-CCC/coconut-vtpm/launch-cvm0.sh
