#!/usr/bin/env bash

SCRIPT_PATH=$(cd $(dirname $0); pwd)    # 包路径

echo "start install gitlab service with docker, should run with root"

read -t 5 -p "continue to execute after 5 seconds, press ctrl+c to cancel ..."

GitLabDir=/mnt/2e3b84aa-9431-45d9-abc8-d6806efd2d8f/gitlab-cn

mkdir -p ${GitLabDir}/etc
mkdir -p ${GitLabDir}/log
mkdir -p ${GitLabDir}/data

docker run \
    --detach \
    --publish 8443:443 \
    --publish 8080:80 \
    --name gitlab \
    --restart unless-stopped \
    --volume ${GitLabDir}/etc:/etc/gitlab \
    --volume ${GitLabDir}/log:/var/log/gitlab \
    --volume ${GitLabDir}/data:/var/opt/gitlab \
    beginor/gitlab-ce