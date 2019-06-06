#!/usr/bin/env bash
# 安装中文支持，使用 UTF-8 编码

###############################
# 1. check language conf
# locale
# 2. add language support
# vi /var/lib/locales/supported.d/local
# zh_CN.UTF-8 UTF-8  
# en_US.UTF-8 UTF-8  
# zh_CN.GBK GBK
# 3. install language support
# dpkg-reconfigure locales
# 4. activate utf-8 encoding
# export LC_ALL=zh_CN.UTF-8
###############################

if [ ! -f /var/lib/locales/supported.d/local ]; then
echo 'enable chinese support'
mkdir -p /var/lib/locales/supported.d/

echo 'zh_CN.UTF-8 UTF-8' >> /var/lib/locales/supported.d/local
echo 'en_US.UTF-8 UTF-8' >> /var/lib/locales/supported.d/local
echo 'zh_CN.GBK GBK' >> /var/lib/locales/supported.d/local

echo apt-get install locales
apt-get install locales
echo dpkg-reconfigure locales with 471 475, default 3
dpkg-reconfigure locales
echo export LC_ALL=zh_CN.UTF-8
else
echo 'local Already Exist'
echo export LC_ALL=zh_CN.UTF-8
fi 
