#!/usr/bin/env bash 
# 统计目录下每个子文件夹下的文件数
if [ $# != 1 ]; then
echo "Usage: $0 image_path"
exit 1;
fi

Folder=$1

for file in `ls $1`
do
    if [ -d $1"/"$file ] 
    then
        path=$1"/"$file 
	echo $path `ls -R $path | wc`		
    fi
done
