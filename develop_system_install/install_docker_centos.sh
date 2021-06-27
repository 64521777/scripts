#!/usr/bin/env bash

SCRIPT_PATH=$(cd $(dirname $0); pwd)    # 包路径


echo "start install docker for centos, should run with root"

read -t 5 -p "continue to execute after 5 seconds, press ctrl+c to cancel ..."

echo "install nvidia-docker"
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-container-runtime/${distribution}/nvidia-container-runtime.repo | sudo tee /etc/yum.repos.d/nvidia-container-runtime.repo
yum install nvidia-container-runtime -y

echo "install docker"
yum install -y yum-utils
yum-config-manager  --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install docker-ce docker-ce-cli containerd.io

echo "update ca-cacert"

echo "start docker service"
systemctl start docker



