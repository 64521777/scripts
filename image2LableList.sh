#!/bin/bash  
if [ $# != 3 ]; then
echo "Usage: $0 image_path file_list_name lable"
echo "e.g.: $0 image/db_fp db_fp_list.txt 0 "
exit 1;
fi
ROOT_DIR=/home/ImageDataSet/
OFFSET=`expr length $ROOT_DIR`

echo $OFFSET

#============ get the file name ===========
Folder=$1
Output_file=$2
lable=$3
: > $Output_file 

echo "Path: $Folder"
echo "Output: $Output_file"
echo "lable: $lable"

function ergodic(){                                                                                                 
for file in $1/*; do
   # echo $1
    if [ -d $file ]
        #echo "directory"
    then
        ergodic $file $2 $3
    else
        #len=`expr length $file - $OFFSET`
        #out=${file:$OFFSET:len}
        echo ${file:$OFFSET}
        echo ${file:$OFFSET} $3 >> $2
    fi
done
}

ergodic $Folder $Output_file $lable
