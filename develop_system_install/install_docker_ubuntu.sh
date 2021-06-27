#!/usr/bin/env bash

SCRIPT_PATH=$(cd $(dirname $0); pwd)    # 包路径


echo "start install docker for ubuntu, should run with root"

read -t 5 -p "continue to execute after 5 seconds, press ctrl+c to cancel ..."

echo "install nvidia-docker"
curl -s -L https://nvidia.github.io/nvidia-container-runtime/gpgkey | sudo apt-key add - distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-container-runtime/${distribution}/nvidia-container-runtime.list | sudo tee /etc/apt/sources.list.d/nvidia-container-runtime.list
apt update
apt nvidia-container-runtime

echo "install docker"
apt-get update
apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update
apt-get install docker-ce docker-ce-cli containerd.io

echo "update ca-cacert"


echo "start docker service"
systemctl start docker



