#!/usr/bin/env bash

SCRIPT_PATH=$(cd $(dirname $0); pwd)    # 包路径

# 安装 python 开发环境
# apt-get install python3-dev python3-pip python3-virtualenv
# which pip3    # /usr/bin/pip3
# echo pip3 install --upgrade pip
# pip3 install --upgrade virtualenv
# pip3 install --upgrade pip

echo "[start] install python conda"

# 安装和配置 conda
if [ ! -e ${SCRIPT_PATH}/Miniconda3-latest-Linux-x86_64.sh ]; then
   wget -O ${SCRIPT_PATH}/Miniconda3-latest-Linux-x86_64.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
   chmod +x ${SCRIPT_PATH}/Miniconda3-latest-Linux-x86_64.sh
fi
chmod +x ${SCRIPT_PATH}/Miniconda3-latest-Linux-x86_64.sh
sh ${SCRIPT_PATH}/Miniconda3-latest-Linux-x86_64.sh

source ~/.bashrc

# 配置 conda 国内源
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/conda-forge
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/msys2/
# 配置 pytorch 源
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/pytorch/
# 设置搜索时显示通道地址
conda config --set show_channel_urls yes

echo "[end] install python conda"
