#!/usr/bin/env bash
# 创建 docker 虚拟机，配置 gluon 开发环境
if [ $# -lt 2 ]; then
echo "Usage: $0 docker_image container_name"
echo "e.g.: $0 ubuntu:16.04 gluon_dev_env"
echo "$0 nvidia/cuda:10.0-cudnn7-devel-ubuntu16.04 gluon_dev_env"
exit 1;
fi

SCRIPT_PATH=$(cd `dirname $0`; pwd)
CURRENR_PATH=$(pwd)

# 1. 创建支持 gpu 的docker容器
# docker run -itd --runtime=nvidia -e NVIDIA_VISIBLE_DEVICES=2,3 --name=mxnet-cu90 -p 9999:8888 -p 1234:22 -v /docker_share/:/root/share nvidia/cuda:9.0-cudnn7-devel bash
docker run -itd --runtime=nvidia --privileged --name=$2 -p 9999:8888 -p 1234:22 -v /opt/:/opt/ -v /data/:/data/:ro -v /cache/:/cache/ $1
