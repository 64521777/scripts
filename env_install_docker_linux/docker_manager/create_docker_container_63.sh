#!/usr/bin/env bash
# 创建 docker 虚拟机，自动指定参数和配置挂载目录
if [ $# -lt 2 ]; then
echo "Usage: $0 docker_image container_name [with_cuda]"
echo "e.g.: $0 kaixhin/cuda-mxnet:8.0 vm_mxnet_cuda"
exit 1;
fi

DOCKER_IMAGE=$1
CONTAINER_NAME=$2

# echo ${DOCKER_IMAGE} ${CONTAINER_NAME}

# 在 63 服务器创建 docker 容器，自动挂载所有的数据盘
if [ $# -gt 2 ]; then
    # docker run --runtime=nvidia --rm nvidia/cuda:9.0-base nvidia-smi  use docker run --runtime=nvidia or nvidia-docker
    nvidia-docker run -itd --privileged --name=${CONTAINER_NAME} -v /opt/:/opt/ -v /data/:/data/:ro -v /cache/:/cache/ ${DOCKER_IMAGE}
else
    docker run -itd --privileged --name=${CONTAINER_NAME} -v /opt/:/opt/ -v /data/:/data/:ro -v /cache/:/cache/ ${DOCKER_IMAGE}
fi

# [可选]设置中文语言
# vim /var/lib/locales/supported.d/local
# 或者
# echo zh_CN.UTF-8 UTF-8 >> /var/lib/locales/supported.d/local
# echo en_US.UTF-8 UTF-8 >> /var/lib/locales/supported.d/local
# echo zh_CN.GBK GBK >> /var/lib/locales/supported.d/local
# 安装设置的语言
# dpkg-reconfigure locales
# 启用中文
# export LC_ALL=zh_CN.UTF-8

# [可选]为创建的容器配置 ssh 服务和启动 ssh 服务
# docker exe -ti ${CONTAINER_NAME} bash
# 安装 ssh 服务
# apt-get install openssh-server
# 启动 ssh 服务
# service ssh start 
