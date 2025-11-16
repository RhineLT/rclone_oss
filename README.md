# rclone OSS HuaweiOBS 挂载容器

本项目用于通过 rclone 挂载华为云 OBS 桶到本地目录。

## 使用方法

### 1. 构建镜像

```bash
docker build -t rclone_oss .
```

### 2. 运行容器

```bash
docker run -d \
  --cap-add SYS_ADMIN \
  --device /dev/fuse \
  -e ACCESS_KEY_ID=你的access_key_id \
  -e SECRET_ACCESS_KEY=你的secret_access_key \
  --name rclone_oss \
  rclone_oss
```

- `ACCESS_KEY_ID` 和 `SECRET_ACCESS_KEY` 请替换为你的华为云密钥。
- 挂载点为 `/mnt/oss/rt-sg`，容器内可直接访问。
- 默认挂载桶名为 `rt-sg`，如需更改请修改 `entrypoint.sh`。
- DNS 服务器已指定为 `100.125.128.250`。

### 3. 推送到远程仓库（可选）

```bash
docker tag rclone_oss ghcr.io/rhinelt/rclone_oss:latest
docker push ghcr.io/rhinelt/rclone_oss:latest
```

## 其他说明
- 镜像基于 Ubuntu 24.04，内置 rclone 和 fuse。
- 挂载采用后台方式（daemon），适合长期运行。
- 如需自定义桶名或挂载参数，请编辑 `entrypoint.sh`。

---

如有问题欢迎反馈！