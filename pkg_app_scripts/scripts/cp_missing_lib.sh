#!/usr/bin/env bash
# 从全量库文件夹里面拷贝缺失依赖库文件到目标文件夹下
if [ $# -lt 2 ]; then
echo "Usage: $0 target alllibpath [destpath]"
echo "e.g.: $0 libc.so localso [`pwd`/lib]"
exit 1;
fi

PWD=`pwd`
BINARYFILE=$1       # 二进制文件
ALLLIBPATH=$2
if [ $# -gt 2 ]; then 
DESTLIBPATH=$3      # 依赖库的拷贝目录
else
DESTLIBPATH=${PWD}/lib      # 依赖库的拷贝目录
fi


######################################
# libcdvs.so => not found
# libavcodec.so.53 => /usr/lib/x86_64-linux-gnu/libavcodec.so.53 (0x00007fc1bb339000)
# deplist=$( ldd $1 | awk '{if (match($3,"not")){ print $1}}' )
# echo $deplist >> $2

# 自动拷贝丢失的依赖库
# -t 表示先打印命令，然后再执行。
# -i 或者是-I，这得看linux支持了，将xargs的每项名称，一般是一行一行赋值给{}，可以用{}代替。
# ldd $1 | awk '{if (match($3,"not")){ print $1}}' | xargs -t -i cp $2/{} .
########################################


# 不断的将缺失库拷贝目标文件夹下，直到没有缺失文件为止
copydeplibs() {
    mkdir -p ${DESTLIBPATH};
    export LD_LIBRARY_PATH=.:${DESTLIBPATH}:${LD_LIBRARY_PATH}
    
    while [ true ]
    do	
        deplist=$( ldd ${BINARYFILE} | grep "not found" | awk '{ print $1}' )
	
        if [ "x$deplist" = "x" ]; then
            break;
        fi

        for libname in ${deplist}; 
	    do
		echo "copy ${libname}"
	        cp ${ALLLIBPATH}/${libname} ${DESTLIBPATH}
	    done;
    done;
}

copydeplibs
# 删除全量库文件夹
# rm -rf ${DESTLIBPATH}
