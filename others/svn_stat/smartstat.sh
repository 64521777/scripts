#!/usr/bin/env bash
# 统计 svn 的提交情况
if [ $# -lt 2 ]; then
echo "Usage: $0 svnpath starttag [endtag]"
echo "e.g.: $0 http://192.168.142.50/svn/general 500"
exit 1;
fi

svn_path=$1
starttag=$2
if [ -z $3 ]; then
  endtag=`svn info ${svn_path} | grep Revision | awk '{print $2}'`
else
  endtag=$3
fi

echo $svn_path $starttag $endtag

for author in sicy baodm linqy chenlin; do
  #echo "./statSVN.sh -t ${svn_path} -s ${starttag} -e ${endtag} -a ${author} -u xujin -p Smart123"
  count=`./statSVN.sh -t ${svn_path} -s ${starttag} -e ${endtag} -a ${author} -u xujin -p Smart123`
  echo "${author}:${count}"
done
