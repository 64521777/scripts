#!/usr/bin/env bash

cpath=`pwd`
echo ${cpath}

sed 's:PWD:'${cpath}':g' train_tpl.txt > train.txt
sed 's:PWD:'${cpath}':g' test_tpl.txt > test.txt
sed 's:PWD:'${cpath}':g' valid_tpl.txt > valid.txt

