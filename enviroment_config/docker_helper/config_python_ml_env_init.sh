#!/usr/bin/env bash

SCRIPT_PATH=$(cd `dirname $0`; pwd)
CURRENR_PATH=$(pwd)
ddstr=`date -Idate`

'''
# [可选]备份和更新软件源
cp /etc/apt/sources.list /etc/apt/sources.list.bak.${ddstr}
cp /opt/share/scripts/sources_16.04.list /etc/apt/sources.list
# 安装必要的软件
apt-get update
apt-get -yqq install build-essential
# 安装和配置 ssh 服务
apt-get install -yqq vim wget sudo openssh-server cmake git
# 这样我们后续就可以通过ssh -p 1234 username@hostip访问容器了。
adduser smart 	# 创建新用户
adduser smart sudo 	# 把用户加入到sudo权限
service ssh start	# 启动ssh服务

# [可选]安装 OpenCV 和 ffmpeg 的依赖项
apt-get -yqq install libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev
apt-get -yqq install libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libjasper-dev libdc1394-22-dev
# [可选]常用工具的安装
apt-get -yqq install cmake git ffmpeg lrzsz  wget curl vim

# 启用中文字符支持: 配置 utf-8 编码
${SCRIPT_PATH}/config_CN_support.sh
export LC_ALL=zh_CN.UTF-8
'''

# 安装必要的软件
apt-get update
apt-get -yqq install build-essential
# 安装和配置 ssh 服务
apt-get install -yqq vim wget sudo openssh-server git cmake
# 这样我们后续就可以通过ssh -p 1234 username@hostip访问容器了。
adduser smart   # 创建新用户
adduser smart sudo      # 把用户加入到sudo权限
service ssh start       # 启动ssh服务
# 安装 opencv 的依赖项
#   File "/root/miniconda3/envs/ml-dev-env/lib/python3.7/site-packages/cv2/__init__.py", line 3, in <module>
#    from .cv2 import *
#   ImportError: libSM.so.6: cannot open shared object file: No such file or directory
apt-get install libglib2.0-0  # ImportError: libgthread-2.0.so.0
apt-get install -y libsm6 libxext6 libxrender-dev # ImportError: libSM.so.6
# 启用中文字符支持: 配置 utf-8 编码
chmod +x ${SCRIPT_PATH}/config_CN_support.sh
sh ${SCRIPT_PATH}/config_CN_support.sh
export LC_ALL=zh_CN.UTF-8

# 安装 python 开发环境
# apt-get install python3-dev python3-pip python3-virtualenv
# which pip3   	# /usr/bin/pip3
# echo pip3 install --upgrade pip
# pip3 install --upgrade virtualenv
# pip3 install --upgrade pip

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

# 创建 python 虚拟环境，管理相关的安装包
conda env create -f ml_enviroment.yml
