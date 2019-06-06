#!/bin/bash
Dst=`pwd`
if [ $# == 1 ];then
    Dst=$1
fi

if [ ! -f SmartVision.tar.gz ];then
    tar -zcvf SmartVision.tar.gz ./bin ./config ./lib
fi
cat InstallAlg.sh SmartVision.tar.gz > ${Dst}/install.bin

rm SmartVision.tar.gz
