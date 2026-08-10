#TMC_PATH="/opt/confidential-containers/storage/repository/lawson\x2Fsecret\x2Fcvm0-tmc"

#if [ -f "$TMC_PATH" ]; then
#    rm "$TMC_PATH"
#    echo "已删除: $TMC_PATH"
#else
#    echo "已删除 (文件不存在，无需操作): $TMC_PATH"
#fi

/home/lawson/data/root/sev-CCC/coconut-vtpm/lawson-scripts/remanufacture-tpm0.sh
