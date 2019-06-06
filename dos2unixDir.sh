#!/usr/bin/env bash
# 扫描目录，对目录下的所有文件，执行 dos2unix 转换，即换行符转换
if [ $# != 2 ]; then
echo "Usage: $0 codepath"
echo "e.g.: $0 /home/smart/svn"
exit 1;
fi

function ergodic(){
for file in ` ls $1`
do
    if [ -d $1"/"$file ] #如果 file存在且是一个目录则为真
    then
        ergodic $1"/"$file
    else
        local path=$1"/"$file #得到文件的完整的目录
        local name=$file       #得到文件的名字
        #做自己的工作.
		`dos2unix ${path}`
	echo $path		
    fi

done
}


function absolutepath() {
local current_dir=`pwd`
local path=`dirname $1`
local filename=`basename $1`
cd "$path"
local path=`pwd`
cd "$current_dir"
return ${path}/${filename}
}

# 相对路径转绝对路径
current_dir=`pwd`
path=`dirname $1`
filename=`basename $1`
cd "$path"
path=`pwd`
inputPath=${path}/${filename}
cd "$current_dir"

ergodic $inputPath
