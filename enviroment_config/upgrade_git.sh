#!/usr/bin/env bash



# 安装 git 编译依赖的第三方库
yum install openssl openssl-devel curl-devel expat-devel
git --version
yum remove git
wget https://www.kernel.org/pub/software/scm/git/git-2.28.0.tar.gz
tar xzvf git-2.28.0.tar.gz
cd git-2.28.0
make prefix=/usr/local/git all
make prefix=/usr/local/git all
echo "export PATH=$PATH:/usr/local/git/bin" >> /etc/bashrc
source /etc/bashrc
git --version