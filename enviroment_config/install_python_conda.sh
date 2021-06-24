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

# 清华大学发了“#关于停止Anaconda镜像服务的通知” ，原因为未获取Anaconda公司授权
# https://zhuanlan.zhihu.com/p/64766956
# ~/.condarc

config_conda_source_cn(){
# 配置 conda 国内源
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/conda-forge
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/msys2/
# 配置 pytorch 源
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/pytorch/
}

config_conda_source(){
# 目前 conda 官方禁了国内的源, 目前，最佳解决办法是删除所有第三方镜像链接，恢复到默认设置，命令如下：
conda config --remove-key channels
conda config --show # 查看conda的配置，确认channels

# 增加r、conda-forge、bioconda的channels：
conda config --add channels r # R软件包
conda config --add channels conda-forge # Conda社区维护的不在默认通道中的软件
conda config --add channels bioconda # 生物信息学类工具
}

# 查看channels是否添加成功
conda config --get channels
# 设置搜索时显示通道地址
conda config --set show_channel_urls yes

echo "[end] install python conda"
