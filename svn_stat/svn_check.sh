#!/usr/bin/env bash

get_svn_update_date()
{  
    svn info $1 | grep 'Last Changed Date' | awk -F ':' '{print $2}' | awk '{print $1}'  
}

update = get_svn_update_date http://192.168.142.50/svn/general
tupdate=`date -d "$svnupdate" +%s`
tlastbackup=`date --date="7 day ago" +%s`

echo $tupdate $tlastbackup

if [ $tupdate -gt $tlastbackup ]; then
    echo "hello"
fi
