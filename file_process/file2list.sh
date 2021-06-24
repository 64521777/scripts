#!/bin/sh  
if [ $# != 2 ]; then
echo "Usage: $0 image_path file_list_name"
echo "e.g.: $0 image/db_fp db_fp_list.txt  "
exit 1;
fi
#============ get the file name ===========  
Folder=$1
Output_file=$2
: > $Output_file                                                                                                  
for file in ${Folder}/*; do
    echo $file  >> $Output_file
done
