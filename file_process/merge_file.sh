#!/usr/bin/env bash 
# 合并目录下指定后缀的文件
if [ $# != 3 ]; then
echo "Usage: $0 extension path resultfile"
echo "e.g.: $0 txt listdir result.txt"
exit 1;
fi

for file in $2/*.$1;do 
    cat $file >> $3;
done
