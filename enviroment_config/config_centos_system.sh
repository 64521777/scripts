#!/usr/bin/env bash

SCRIPT_PATH=$(cd $(dirname $0); pwd)    # 包路径

echo "start config centos, should run with root"

read -t 5 -p "continue to execute after 5 seconds, press ctrl+c to cancel ..."

wget http://mirrors.aliyun.com/repo/Centos-7.repo

cp Centos-7.repo /etc/yum.repos.d/ 
cd /etc/yum.repos.d/ 
mv CentOS-Base.repo CentOS-Base.repo.bak 
mv Centos-7.repo CentOS-Base.repo

mv elrepo.repo elrepo.repo.bak
mv epel.repo epel.repo.ba
mv epel-testing.repo epel-testing.repo.ba

yum clean all 
yum makecache