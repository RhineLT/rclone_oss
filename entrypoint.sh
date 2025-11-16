#!/bin/bash
set -e

# 生成 rclone 配置文件
cat > /rclone.conf <<EOF
[oss]
type = s3
provider = HuaweiOBS
access_key_id = ${ACCESS_KEY_ID}
secret_access_key = ${SECRET_ACCESS_KEY}
region = ap-southeast-3
endpoint = obs.ap-southeast-3.myhuaweicloud.com
upload_cutoff = 500Mi
chunk_size = 128Mi
EOF

# 挂载 OSS 桶
rclone mount oss:rt-sg /mnt/oss/rt-sg \
    --config /rclone.conf \
    --daemon \
    --allow-other \
    --vfs-cache-mode writes \
    --s3-provider HuaweiOBS \
    --s3-endpoint obs.ap-southeast-3.myhuaweicloud.com \
    --s3-region ap-southeast-3
