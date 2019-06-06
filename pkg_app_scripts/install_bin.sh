#!/bin/bash

export DIR=`pwd`
BIN=${DIR}/bin
BINARYFILE=XMLRPC_Server
LIB=${DIR}/lib

SYSTEM="unknown"
VER=0.0

install_centos()
{
    if [[ ${VER} == 6* ]]; then
       cp -rf Centos/6.9/bin    .
       cp -rf Centos/6.9/deplib .
    elif [[ ${VER} == 7* ]]; then
       cp -rf Centos/7.3/bin    .
       cp -rf Centos/7.3/deplib .
    fi
}

install_ubuntu()
{
    #if [[ ${VER} == 14\.04* ]]; then
       cp -rf Ubuntu/14.04/bin    .
       cp -rf Ubuntu/14.04/deplib .
    #fi
}

copydeplibs() {
    mkdir ${LIB}
    export CURRENTDIR=`pwd`
    export LD_LIBRARY_PATH=.:${DIR}/lib/:/usr/local/lib/:/usr/lib/:$LD_LIBRARY_PATH
    
    while [ true ]
    do	
        deplist=$( ldd ${BIN}/${BINARYFILE} | grep "not found" | awk '{ print $1}' )
	
        if [ "x$deplist" = "x" ]; then
            break;
        fi

        for libname in ${deplist}; 
	    do
	        cp deplib/${libname} ${LIB}
	    done;
    done;
}


installall() {
    sed -n -e '1,/^exit 0$/!p' $0 > "SmartVision.tar.gz" 2>/dev/null
    tar -zxvf SmartVision.tar.gz

    echo $SYSTEM
    if [ ${SYSTEM} == "centos" ]; then
        install_centos
        echo centos
    elif [ ${SYSTEM} == "ubuntu" ]; then
        install_ubuntu
        echo ubuntu
    fi
    
    #sed -i "s#/opt/SmartVisionDemo/#${DIR}/#g"  `grep opt/SmartVisionDemo -rl *.sh`
    #sed -i "s#/opt/SmartVisionDemo/#${DIR}/#g"  `grep opt/SmartVisionDemo -rl config`
    #sed -i "s#/opt/SmartVisionDemo/#${DIR}/#g"  `grep opt/SmartVisionDemo -rl Data`

    copydeplibs

    #export LD_LIBRARY_PATH=${DIR}/lib/:/usr/local/lib/:/usr/lib/:$LD_LIBRARY_PATH
    #sh ${DIR}/stop_server.sh
    #sh ${DIR}/run_server.sh
    #ps -ef|grep XML
}

installpart() {
    sed -n -e '1,/^exit 0$/!p' $0 > "SmartVision.tar.gz" 2>/dev/null
    mkdir -p tmp/smartvision
    cp SmartVision.tar.gz tmp/smartvision

    cd tmp/smartvision
    tar -zxvf SmartVision.tar.gz
    if [ $SYSTEM==centos ]; then
        install_centos
    elif [ $SYSTEM==ubuntu ];then
        install_ubuntu
    fi
    
    sh ${DIR}/stop_server.sh
    rm -rf ${DIR}/bin
    cp -rf bin ${DIR}/.
    
    cd ${DIR}
    sh ${DIR}/run_server.sh
    ps -ef|grep XML

    rm -rf tmp/smartvision
}

if [ -n "`cat /etc/redhat-release | grep CentOS`" ]; then
    SYSTEM="centos"
    VER=$(cat /etc/redhat-release | awk '{for(i=1; i<=NF; i++ ) if($i ~ /[0-9]/) print $i}')
    echo ${VER}
elif [ -n "`cat /etc/issue | grep Ubuntu`" ]; then
    SYSTEM="ubuntu"
    VER=$(cat /etc/issue  | awk '{for(i=1; i<=NF; i++ ) if($i ~ /[0-9]/) print $i}')
    echo ${VER}
fi

if [ -d bin ]; then
    installpart
else
    installall
fi


rm -rf SmartVision.tar.gz
rm -rf install.sh
rm -rf deplib
rm -rf Centos
rm -rf Ubuntu

#sh -c 'echo "${DIR}/lib" > /etc/ld.so.conf.d/smartvision.conf'
#ldconfig

exit 0
