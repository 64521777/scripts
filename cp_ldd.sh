#!/usr/bin/env bash
# 将程序的依赖库拷贝到指定目录
if [ $# -lt 2 ]; then
echo "Usage: $0 binary destpath [prefix]"
echo "e.g.: $0 libc.so localso /usr/local"
exit 1;
fi

binfile=$1
destpath=$2

if [ $# -gt 2 ]; then
regprefix=$3
# 将动态库或者可执行程序的依赖文件拷贝到指定文件
deplist=$( ldd $binfile | awk '{if (match($3,"$regprefix")){ print $3}}' )
else
deplist=$( ldd $binfile | awk '{if (match($3,"/")){ print $3}}' )
fi
cp $deplist $destpath
