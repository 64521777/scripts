#!/usr/bin/env bash
# copy missing libs, and reconfig packages

# 脚本的父路径为包路径
SCRIPT_DIR=$(cd $(dirname $0); pwd)
PKG_PATH=`dirname ${SCRIPT_DIR}`

export LD_LIBRARY_PATH=.:${PKG_PATH}/lib/:/usr/local/lib/:/usr/lib/
mkdir -p ${PKG_PATH}/lib/
cd ${PKG_PATH}

# 拷贝依赖库, 然后删除无用的依赖库
${SCRIPT_DIR}/cp_missing_lib.sh bin/XMLRPC_Server_NK ${PKG_PATH}/lib ${PKG_PATH}/deplib
rm -fr ${PKG_PATH}/deplib;

# 根据包目录编辑配置文件
mkdir -p ${PKG_PATH}/config;
cp -fr ${PKG_PATH}/config_template/* ${PKG_PATH}/config/
for f in `ls ${PKG_PATH}/config`
do
    #echo "1: $f"
    sed -i "s#@PKG_PATH@#${PKG_PATH}#g" ${PKG_PATH}/config/$f
done
