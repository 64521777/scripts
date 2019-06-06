#!/usr/bin/env bash 
# 扫描目录，输出目录下的文件列表，并在后面加上自定义标签
if [ $# != 3 ]; then
echo "Usage: $0 image_path listfile lable"
echo "e.g.: $0 image/db_fp db_fp_list.txt 0 "
exit 1;
fi

Folder=$1
Output_file=$2
lable=$3

function ergodic(){
for file in `ls $1`
do
    if [ -d $1"/"$file ] 
    then
        ergodic $1"/"$file $2 $3
    else
        local path=$1"/"$file 
        local name=$file       
        echo $path/$name $3 >> $2
	echo $path		
    fi
done
}

ergodic $Folder $Output_file $lable
