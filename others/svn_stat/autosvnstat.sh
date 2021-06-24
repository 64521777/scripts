#!/usr/bin/env bash
# 统计 svn 的提交情况
rm tempsvnlist.txt

while read line
do
  svn_path=`echo ${line} | awk '{print $1}'`
  starttag=`echo ${line} | awk '{print $3}'`
  endtag=`svn info ${svn_path} | grep Revision | awk '{print $2}'`
  echo "${svn_path} ${starttag} ${endtag}"
  for author in sicy baodm linqy chenlin; do
    count=`./statSVN.sh -t ${svn_path} -s ${starttag} -e ${endtag} -a ${author} -u xujin -p Smart123`
    echo -e "\t${author}:${count}"
  done

  echo ${svn_path} ${starttag} ${endtag} >> tempsvnlist.txt
done < svnlist.txt

mv tempsvnlist.txt svnlist.txt

