#!/usr/bin/env bash

OS_DISTRIBUTE=`cat /etc/*release | grep ^NAME`

if cat /etc/*release | grep ^NAME | grep CentOS; then
	echo "==============================================="
    echo "Upgrade gcc on Ubuntu"
    echo "==============================================="
	add-apt-repository ppa:ubuntu-toolchain-r/test -y
	apt-get update -y
	apt-get install g++-7 -y
elif cat /etc/*release | grep ^NAME | grep Ubuntu; then
	echo "==============================================="
    echo "Upgrade gcc on CentOS"
    echo "==============================================="
	yum install centos-release-scl
	yum install devtoolset-7
	scl enable devtoolset-7 bash
else
	echo "OS NOT SUPPORTED, couldn't upgrade gcc"
	echo "${OS_DISTRIBUTE}"
	exit 1;
fi