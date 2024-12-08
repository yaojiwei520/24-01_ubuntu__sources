#!/bin/bash

# 定义备份和配置文件路径
SOURCE_FILE="/etc/apt/sources.list.d/ubuntu.sources"
BACKUP_FILE="/etc/apt/sources.list.d/ubuntu.sources.bak"

# 备份现有的 ubuntu.sources 配置文件
if [ -f "$SOURCE_FILE" ]; then
    echo "备份现有的 ubuntu.sources 配置文件..."
    sudo cp "$SOURCE_FILE" "$BACKUP_FILE"
    echo "备份完成，保存为 $BACKUP_FILE"
else
    echo "未找到现有的 ubuntu.sources 文件，跳过备份。"
fi

# 清除原有的配置内容
echo "清除原有的 ubuntu.sources 配置内容..."
echo "" | sudo tee "$SOURCE_FILE" > /dev/null

# 写入新的软件源配置
echo "正在写入新的软件源配置..."
sudo tee "$SOURCE_FILE" > /dev/null <<EOL
# 默认软件源
Types: deb
URIs: https://mirrors.tuna.tsinghua.edu.cn/ubuntu
Suites: noble noble-updates noble-backports
Components: main restricted universe multiverse
Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg

# 默认注释了源码镜像以提高 apt update 速度，如有需要可自行取消注释
# Types: deb-src
# URIs: https://mirrors.tuna.tsinghua.edu.cn/ubuntu
# Suites: noble noble-updates noble-backports
# Components: main restricted universe multiverse
# Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg

# 安全更新软件源
Types: deb
URIs: http://security.ubuntu.com/ubuntu/
Suites: noble-security
Components: main restricted universe multiverse
Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg

# Types: deb-src
# URIs: http://security.ubuntu.com/ubuntu/
# Suites: noble-security
# Components: main restricted universe multiverse
# Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg

# 预发布软件源，不建议启用

# Types: deb
# URIs: https://mirrors.tuna.tsinghua.edu.cn/ubuntu
# Suites: noble-proposed
# Components: main restricted universe multiverse
# Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg

# # Types: deb-src
# # URIs: https://mirrors.tuna.tsinghua.edu.cn/ubuntu
# # Suites: noble-proposed
# # Components: main restricted universe multiverse
# # Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg
EOL

# 更新软件包信息
echo "配置完成，更新软件包信息..."
sudo apt update

echo "操作完成！"
