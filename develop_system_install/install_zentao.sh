#!/usr/bin/env bash

SCRIPT_PATH=$(cd $(dirname $0); pwd) 

echo "start install zentao service with docker, should run with root"

read -t 5 -p "continue to execute after 5 seconds, press ctrl+c to cancel ..."

# docker pull easysoft/zentao:12.3.3

ZentaoDir=/mnt/2e3b84aa-9431-45d9-abc8-d6806efd2d8f/zentao


mkdir -p ${zentao}/zentaopms
mkdir -p ${zentao}/mysqldata

docker run \
    --detach \
    --publish 9443:443 \
    --publish 9080:80 \
    --name zentao \
    --restart unless-stopped \
    --volume ${ZentaoDir}/zentaopms:/www/zentaopms \
    --volume ${ZentaoDir}/mysqldata:/var/lib/mysql \
	--env MYSQL_ROOT_PASSWORD=123456 \
    easysoft/zentao:12.3.3