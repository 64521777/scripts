#!/usr/bin/env bash
# 安装必要的基础软件以及ssh服务


# 安装必要的软件
apt-get update
apt-get -yqq install vim wget unzip lrzsz pkg-config build-essential
apt-get -yqq install lsof strace
# 安装和配置 ssh 服务
apt-get install -yqq sudo openssh-server
# 这样我们后续就可以通过ssh -p 1234 username@hostip访问容器了。
adduser smart   # 创建新用户
adduser smart sudo      # 把用户加入到sudo权限
service ssh start       # 启动ssh服务

# 为了 ssh 可以获取 root 权限，需要设置 root 密码
# passwd
