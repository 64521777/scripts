#!/usr/bin/env bash

SCRIPT_PATH=$(cd `dirname $0`; pwd)
CURRENR_PATH=$(pwd)
ddstr=`date -Idate`

# 安装系统更新以及必要的软件: wget, ssh 服务等
sh {SCRIPT_PATH}/install_system_essential.sh
# 启用中文字符支持: 配置 utf-8 编码
sh ${SCRIPT_PATH}/config_CN_support.sh
# 安装 Python 开发环境
sh ${SCRIPT_PATH}/install_python_conda.sh

# 安装 opencv 的依赖项
#   File "/root/miniconda3/envs/ml-dev-env/lib/python3.7/site-packages/cv2/__init__.py", line 3, in <module>
#    from .cv2 import *
#   ImportError: libSM.so.6: cannot open shared object file: No such file or directory
apt-get install libglib2.0-0  # ImportError: libgthread-2.0.so.0
apt-get install -y libsm6 libxext6 libxrender-dev # ImportError: libSM.so.6

# 使用中文
export LC_ALL=zh_CN.UTF-8


####### 1. 配置 keras, sklearn 机器学习开发环境 #######
config_ml_env(){
conda env create -f ${SCRIPT_PATH}config/ml_enviroment.yml
source activate ml-dev-env
}

####### 2. 配置 gluon 开发环境 #######
config_gluon_env(){
# 创建 python 虚拟环境，管理相关的安装包
conda env create -f ${SCRIPT_PATH}/config/gluon_environment.yml

# 激活之前创建的环境, 并启动 jupyter
source activate gluon
cd /opt/share/model_train/d2l-gluon-zh/
set MXNET_GLUON_REPO=https://apache-mxnet.s3.cn-north-1.amazonaws.com.cn/; jupyter notebook --ip=0.0.0.0 --allow-root &
}

config_ml_env
