#!/usr/bin/env bash

# 启动容器
nvidia-docker start caffe_cuda8_dev
# 设置 ip
pipework br0 bd6110fe5c86 192.168.142.38/24@192.168.142.1
# 启动进入 docker 服务器, 并启动 ssh 服务
docker exec -ti caffe_cuda8_dev service ssh start
