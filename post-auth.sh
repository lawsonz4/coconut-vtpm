curl -X POST http://localhost:8003/kbs/v0/auth \
-v -i \
-H "Content-Type: application/json" \
-d '{"version":"0.1.0","tee":"snp","extra-params":""}'
