timeout 3s /home/lawson/data/root/sev-CCC/coconut-vtpm/lawson-scripts/reset-system.sh || true
/home/lawson/data/root/sev-CCC/coconut-vtpm/lawson-scripts/start-aproxy0-only.sh &
/home/lawson/data/root/sev-CCC/coconut-vtpm/lawson-scripts/launch-cvm0.sh
