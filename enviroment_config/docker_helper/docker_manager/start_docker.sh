#!/usr/bin/env bash

if [ $# -lt 2 ]; then
echo "Usage: $0 container_name [container_id private_ip]"
echo "e.g.: $0 ubuntu_14.04_lyc c02838478b09 192.168.142.34"
exit 1;
fi


container_name=$1

# 启动容器
docker start ${container_name}

# 设置 ip
if [ $# -ge 3 ]; then
container_id=$2
private_ip=$3
pipework br0 ${container_id} ${private_ip}/24@192.168.142.1
fi

# 启动进入 docker 服务器, 并启动 ssh 服务
docker exec -ti ${container_name} service ssh start

# 检查
count=`docker ps | grep ${container_name} | grep -v "grep" | wc -l`
if [ 0 == $count ];then
echo "Container ${container_name} Start Failed!"
else
echo "Container ${container_name} Start Success!"
fi

