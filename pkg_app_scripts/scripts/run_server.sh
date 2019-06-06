#!/usr/bin/env bash
#rm -rf /opt/SmartVision/system/userdb/copyright/*.txt;

# 脚本的父路径为包路径
SCRIPT_DIR=$(cd $(dirname $0); pwd)
PKG_PATH=`dirname ${SCRIPT_DIR}`

export LD_LIBRARY_PATH=.:${PKG_PATH}/lib/:/usr/local/lib/:/usr/lib/

nohup ${PKG_PATH}/bin/XMLRPC_Server_NK ${PKG_PATH}/config/smartvisionvfpfilter.prototxt 12000 &>>${PKG_PATH}/result/logvf.txt &
echo "All service started..."
