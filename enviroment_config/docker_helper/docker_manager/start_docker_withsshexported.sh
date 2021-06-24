#!/usr/bin/env bash
# 创建 docker 虚拟机，配置 gluon 开发环境
if [ $# -lt 3 ]; then
echo "Usage: $0 docker_image container_name ssh_export_port"
echo "e.g.: $0 nvidia/cuda:10.0-cudnn7-devel-ubuntu16.04 gluon_dev_env 1234"
exit 1;
fi

SCRIPT_PATH=$(cd `dirname $0`; pwd)
CURRENR_PATH=$(pwd)

# 1. 创建支持 gpu 和 ssh 端口导出的docker容器
docker run -itd --runtime=nvidia --privileged --name=$2 -p $3:22 -v /opt/:/opt/ -v /data/:/data/:ro -v /cache/:/cache/ $1
