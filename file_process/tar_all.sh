#!/bin/bash
for file in $1/*.tar; do
    echo $file
    len=`expr length $file - 4`
    prefix=${file:0:len}
    echo $prefix
    mkdir $prefix
    tar xvf $file -C $prefix
    rm $file
done
