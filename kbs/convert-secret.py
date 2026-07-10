import base64

# 粘贴你的base64字符串
b64_str = "r4I8OSxiLfCey6IdvW0Vz4MoTEpjQM7sVfFa5mqhICGL0RsSbbniuWcVdOLS9pfqDBA512gTYLT94XpNW4s7vw=="

# 解码为字节数组
data_bytes = base64.b64decode(b64_str)

# 写入bin文件
with open("secret.bin", "wb") as f:
    f.write(data_bytes)

print("解码完成，已生成 secret.bin")
print(f"字节数组长度：{len(data_bytes)}")
