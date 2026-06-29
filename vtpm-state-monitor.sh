#!/bin/bash

# 监控 svsm-state.raw 文件变化脚本
# 使用 OpenSSL SM3 算法检测文件哈希变化

FILE="svsm-state.raw"
INTERVAL=1  # 检查间隔（秒）

# 检查文件是否存在
if [ ! -f "$FILE" ]; then
    echo "错误: 文件 $FILE 不存在"
    exit 1
fi

# 检查 openssl 是否支持 sm3
if ! openssl dgst -sm3 /dev/null 2>/dev/null; then
    echo "错误: OpenSSL 不支持 SM3 算法"
    exit 1
fi

# 获取初始哈希值
get_hash() {
    openssl dgst -sm3 "$FILE" | awk '{print $NF}'
}

LAST_HASH=$(get_hash)
echo "[$(date '+%Y-%m-%d %H:%M:%S')] 开始监控: $FILE"
echo "[$(date '+%Y-%m-%d %H:%M:%S')] 初始 SM3: $LAST_HASH"

# 监控循环
while true; do
    sleep $INTERVAL
    
    # 检查文件是否仍然存在
    if [ ! -f "$FILE" ]; then
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] 警告: 文件 $FILE 已消失"
        continue
    fi
    
    CURRENT_HASH=$(get_hash)
    
    # 比较哈希值
    if [ "$CURRENT_HASH" != "$LAST_HASH" ]; then
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] 文件变化 detected!"
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] 旧 SM3: $LAST_HASH"
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] 新 SM3: $CURRENT_HASH"
        echo "---"
        LAST_HASH="$CURRENT_HASH"
    fi
done
