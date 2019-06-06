#!/usr/bin/env bash

cd /opt/SmartVision
./stop_server.sh
echo 'stop XML finish'
cd /data/result/
rm -f /data/video/src_video/*
echo 'clear /data/video/src_video/  finish'
rm -rf /data/video/test_video/*
echo '/data/video/test_video/'

rm -f /opt/SmartVision/system/userdb/sis/migu.txt
echo '/opt/SmartVision/system/userdb/sis/migu.txt'
rm -f /opt/SmartVision/fp.txt
echo '/opt/SmartVision/fp.txt'
rm -f /data/sift/dbfp/*
echo '/data/sift/dbfp'
rm -f /opt/SmartVision/lmdbfpdb/*
echo '/opt/SmartVision/lmdbfpdb'


rm -f /openapi/video/result/*
echo '/openapi/video/result/'
rm -f /opt/SmartVision/list/*
rm -f /data/result/result.txt
echo '/data/result/result.txt'

echo 'clean env ok'
