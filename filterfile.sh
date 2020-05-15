

filter_filesize(){
filesize=`ls -l "$filepath" | awk '{ print $5 }'`
minsize=$((10*1024*1024))
if [ $filesize -gt $minsize ]
then
    md5name=`md5sum "$filepath"`
    echo "${md5name}" >> $2
fi 
}