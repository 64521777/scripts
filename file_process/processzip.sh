#!/usr/bin/env bash
#usage: $0 inputFile resultPath

path=`dirname $1`
filename=`basename $1`
inputFile=${path}/${filename}

if [ -d $inputFile ]; then
	echo "process file"
elif [ ${inputFile/".zip"} ]; then
	current_dir=`pwd`
	tmpPath=${path}/tmp
	`mkdir $tmpPath`
	cd "$tmpPath"
	`unzip $inputFile`
	cd "$current_dir"
	echo "process tmp path"
fi
