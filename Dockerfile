FROM ubuntu:22.04

# 安装必要工具
RUN apt-get update && \
    apt-get install -y fuse wget && \
    rm -rf /var/lib/apt/lists/*

# 添加 rclone 二进制文件
COPY rclone-v1.71.2-linux-amd64/rclone /usr/bin/rclone
RUN chmod +x /usr/bin/rclone

# 创建挂载点
RUN mkdir -p /mnt/oss/rt-sg

# 启动脚本
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
