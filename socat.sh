# 假设原 socket 路径
ORIGINAL_SOCK="/home/lawson/data/root/sev-CCC/coconut-vtpm/svsm-proxy.sock"
BACKUP_SOCK="/home/lawson/data/root/sev-CCC/coconut-vtpm/svsm-proxy.sock.backup"

# 备份原 socket
mv $ORIGINAL_SOCK $BACKUP_SOCK

# 创建 socat 中间人，双向打印流量
socat -t100 -x -v \
    UNIX-LISTEN:$ORIGINAL_SOCK,mode=777,reuseaddr,fork \
    UNIX-CONNECT:$BACKUP_SOCK \
    2>&1 | tee /tmp/aproxy_traffic.log
