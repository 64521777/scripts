#! /bin/bash

###############################################################
##                       LOCAL Function                   #####
###############################################################

function MakeRun()
{
    local bin=$1
    local name=$2
    local cfg_file=$3
    local port=$4
    echo -e "if [ 0 == \`ps -ef |grep \$CurDir/bin/${bin} |grep ${cfg_file} | grep -v \"grep\" |wc -l\` ];then" >> ${server_install_path}/run_server.sh
    echo "    nohup \$CurDir/bin/${bin} \$CurDir/config/${cfg_file} ${port} &>>/dev/null &" >> ${server_install_path}/run_server.sh
    echo -e "    echo \"Start ${name} Server ... \"" >> ${server_install_path}/run_server.sh
    echo "    sleep 1" >> ${server_install_path}/run_server.sh 
    echo "else" >> ${server_install_path}/run_server.sh
    echo -e "    echo \"${name} Server is Running ... \"" >> ${server_install_path}/run_server.sh
    echo "fi" >> ${server_install_path}/run_server.sh   
}
function MakeStop()
{
    local bin=$1
    local name=$2
    local cfg_file=$3
    echo "if [ 0 == \`ps -ef |grep \$CurDir/bin/${bin} |grep ${cfg_file} | grep -v \"grep\" |wc -l\` ];then" >> ${server_install_path}/stop_server.sh
    echo -e "    echo \"${name} is Down\"" >> ${server_install_path}/stop_server.sh
    echo "else" >> ${server_install_path}/stop_server.sh
    echo "    ps -ef | grep \$CurDir/bin/${bin} |grep ${cfg_file} | grep -v grep|cut -c 9-15| xargs kill -s 9" >> ${server_install_path}/stop_server.sh
    echo "fi" >> ${server_install_path}/stop_server.sh
}

function MakeRunScript()
{
    local model=$1
    if [[ ${model} == "head" ]];then
        echo "#!/usr/bin/env bash" > ${server_install_path}/run_server.sh
        echo "CurDir=\`pwd\`" >> ${server_install_path}/run_server.sh
        echo "" >> ${server_install_path}/run_server.sh
        echo "#java -jar LoadFPSis.jar \$CurDir/system/data/vfp/userdb/sis/" >> ${server_install_path}/run_server.sh
        echo -e "export LD_LIBRARY_PATH=.:\$CurDir/lib/:\$LD_LIBRARY_PATH" >> ${server_install_path}/run_server.sh
        echo "" >> ${server_install_path}/run_server.sh
    elif  [[ ${model} == "色情服务" ]];then
        MakeRun ${BINARY} Nudity SmartVisionNudityFilter.prototxt $2   
    elif  [[ ${model} == "指纹比对" ]];then        
        MakeRun ${BINARY} VFP SmartVisionVfpFilter.prototxt $2     
    elif  [[ ${model} == "人脸服务" ]];then    
        MakeRun ${BINARY} Face SmartVisionFace.prototxt $2       
    elif  [[ ${model} == "视频解码服务" ]];then 
        MakeRun VideoDecoderSever VideoDecode SmartVisionVideoDecoder.prototxt
    fi
}

function MakeStopScript()
{
    local model=$1
    if [[ ${model} == "head" ]];then
        echo "#!/usr/bin/env bash" > ${server_install_path}/stop_server.sh
        echo "CurDir=\`pwd\`" >> ${server_install_path}/stop_server.sh
        echo "" >> ${server_install_path}/run_server.sh
    elif  [[ ${model} == "色情服务" ]];then
        MakeStop ${BINARY} Nudity SmartVisionNudityFilter.prototxt  
    elif  [[ ${model} == "指纹比对" ]];then          
        MakeStop ${BINARY} VFP SmartVisionVfpFilter.prototxt      
    elif  [[ ${model} == "人脸服务" ]];then           
        MakeStop ${BINARY} Face SmartVisionFace.prototxt
    elif  [[ ${model} == "视频解码服务" ]];then
        MakeStop VideoDecoderSever VideoDecode SmartVisionVideoDecoder.prototxt
    fi
}

function TryCp()
{
    local SRC=$1
    local FILE=$2
    local DST=$3
    if [ ! -f ${DST}/${FILE} ];then
        cp -f $SRC/${FILE} ${DST}
    fi
}

function TryMkdir()
{
    local SRC=$1
    
    if [ ! -d ${SRC} ];then
        mkdir -p $SRC
    fi
}

function MakeBin()
{
    local SRC=$1
    TryMkdir ${server_install_path}/bin
    
    if [ "x${key_selected}" == "x" ];then
        TryCp ${SRC} GenSystemID ${server_install_path}/bin
        TryCp ${SRC} GenID.sh ${server_install_path}/bin     
    fi
    for server in ${server_selected[@]}; do
        server=`expr $server - 1`
        if [[ ${SeverSupportName[${server}]} == "色情服务" ]];then
            TryCp ${SRC} ${BINARY_SRC} ${server_install_path}/bin/${BINARY}
        elif [[ ${SeverSupportName[${server}]} == "指纹比对" ]];then 
            TryCp ${SRC} ${BINARY_SRC} ${server_install_path}/bin/${BINARY}
            TryCp ${SRC} VFP_Gen ${server_install_path}/bin
            TryCp ${SRC} LoadFPSis.jar ${server_install_path}/bin
            TryCp ${SRC} runVFPGen.sh ${server_install_path}/bin
        elif [[ ${SeverSupportName[${server}]} == "人脸服务" ]];then 
            TryCp ${SRC} ${BINARY_SRC} ${server_install_path}/bin/${BINARY}
            TryCp ${SRC} FaceAnalyze ${server_install_path}/bin
        elif [[ ${SeverSupportName[${server}]} == "视频解码服务" ]];then
            TryCp ${SRC} VideoDecoderSever ${server_install_path}/bin
            TryCp ${SRC} VideoDecoderTool ${server_install_path}/bin
            TryCp ${SRC} runVideoDecode.sh ${server_install_path}/bin
        fi
    done
    
}

function MakeLib() {
    local SRC=$1
    
    TryMkdir ${server_install_path}/lib 
    export CURRENTDIR=`pwd`
    export LD_LIBRARY_PATH=.:${server_install_path}/lib/:/usr/local/lib/:/usr/lib/:$LD_LIBRARY_PATH
    
    while [ true ]
    do	
        deplist=$(ldd ${server_install_path}/bin/${BINARY} | grep "not found" | awk '{ print $1}')
	
        if [ "x$deplist" = "x" ]; then
            break;
        fi
        
        for libname in ${deplist}; 
	    do  
            if [ -f ${SRC}/${libname} ];then
	            cp ${SRC}/${libname} ${server_install_path}/lib
            else
                echo "Miss ${libname}"
                break
            fi
	    done;
    done;
}
function MakeCfg()
{
    local SRC=$1
    TryMkdir ${server_install_path}/config
    TryMkdir ${server_install_path}/config/data
    TryMkdir ${server_install_path}/config/module
    
    for server in ${server_selected[@]}; do
        server=`expr $server - 1`
        if [[ ${SeverSupportName[${server}]} == "色情服务" ]];then
            TryCp ${SRC} SmartVisionNudityFilter.prototxt ${server_install_path}/config
            TryCp ${SRC}/module nudityfilter.prototxt ${server_install_path}/config/module
            TryCp ${SRC}/data deploy_nudity_res_4_crypto.prototxt ${server_install_path}/config/data
            TryCp ${SRC}/data nudity_weight_res_4_crypto.binaryproto ${server_install_path}/config/data
        elif [[ ${SeverSupportName[${server}]} == "指纹比对" ]];then 
            TryCp ${SRC} SmartVisionVfpFilter.prototxt ${server_install_path}/config
            TryCp ${SRC}/module vfpfilter.prototxt ${server_install_path}/config/module
        elif [[ ${SeverSupportName[${server}]} == "人脸服务" ]];then 
            TryCp ${SRC} SmartVisionFace.prototxt ${server_install_path}/config
            TryCp ${SRC}/module facemodule.prototxt ${server_install_path}/config/module
            TryCp ${SRC}/data shape_predictor_68_face_landmarks.dat ${server_install_path}/config/data
            TryCp ${SRC}/data dlib_face_recognition_resnet_model_v1.dat ${server_install_path}/config/data
        elif [[ ${SeverSupportName[${server}]} == "视频解码服务" ]];then
            TryCp ${SRC} SmartVisionVideoDecoder.prototxt ${server_install_path}/config
            TryCp ${SRC}/module videodecoder.prototxt ${server_install_path}/config/module
        fi
    done
    sed -i "s#./system/data/#${server_install_path}/system/data/#g"  `grep ./system/data -rl ${server_install_path}/config/module`
}

###############################################################
##                       Main Function                   #####
###############################################################
# 算法安装脚本: 
# 1. 用户安装信息输入并生成安装信息
# 2. 解压安装包
# 3. 按照用户要求安装程序.
# 4. 生成相关脚本和目录
# 5. 安装完成之后删除无关项
CurrentDir=`pwd`
SeverSupportName=("色情服务" "指纹比对" "人脸服务" "视频解码服务")
APISupportName=("XMLRPC" "Http")
OLD_IFS=$IFS 
IFS="," 
stty erase '^H'  # 退格
server_selected=(1 2 3 4)
echo "请选择安装服务[输入编号]: 多个服务用','分割,默认全部安装"
for(( i=0;i<${#SeverSupportName[@]};i++)); do 
    echo -e "`expr $i + 1`. ${SeverSupportName[${i}]}; \c"
done;
read server_selected_str
if [[ ${server_selected_str} != "" ]];then
    server_selected=($server_selected_str)
fi 
IFS=$OLD_IFS  
echo "请选择API方式[输入编号]:默认XMLRPC"
for(( i=0;i<${#APISupportName[@]};i++)); do 
    echo -e "`expr $i + 1`.${APISupportName[${i}]}; \c"
done;
api_selected=0
read api_selected_str
if [[ ${api_selected_str} != "" ]];then
    api_selected=$(expr ${api_selected_str} - 1)
fi

key_selected=""
echo "请选择KEY版本: KEY---1, NO_KEY---0, 默认为KEY"
read key_selected_str
if [[ ${key_selected_str} == "0" ]];then
    key_selected="_NK"
fi

server_install_path="/opt/SmartVision"
echo "请选择安装路径: 默认/opt/SmartVision"
read server_install_path_str
if [[ ${server_install_path_str} != "" ]];then
    server_install_path=${server_install_path_str}
fi

if [ ! -d ${server_install_path} ];then
    mkdir -p ${server_install_path}
fi
#echo ${server_install_path}
MakeRunScript "head"
MakeStopScript "head"
# 每个服务设置
BINARY=${APISupportName[${api_selected}]}_Server${key_selected}
BINARY_SRC=${BINARY}

for server in ${server_selected[@]}; do
    server=`expr $server - 1`
    if [[ ${SeverSupportName[${server}]} == "色情服务" ]];then
        echo "请输入色情服务端口号, 默认: 11000"
        read server_port
        if [[ ${server_port} == "" ]];then
            server_port=11000
        fi 
        MakeRunScript "色情服务"  ${server_port}
        MakeStopScript "色情服务"
    elif [[ ${SeverSupportName[${server}]} == "指纹比对" ]];then 
        echo "请输入指纹比对端口号, 默认: 12000"
        read server_port   
        if [[ ${server_port} == "" ]];then
            server_port=12000
        fi     
        MakeRunScript "指纹比对" ${server_port}
        MakeStopScript "指纹比对"
    elif [[ ${SeverSupportName[${server}]} == "人脸服务" ]];then    
        echo "请输入人脸服务端口号, 默认: 13000"   
        read server_port
        if [[ ${server_port} == "" ]];then
            server_port=13000
        fi 
        MakeRunScript "人脸服务" ${server_port}
        MakeStopScript "人脸服务"
    elif [[ ${SeverSupportName[${server}]} == "视频解码服务" ]];then
        BINARY_SRC=${BINARY_SRC}_RD
        MakeRunScript "视频解码服务"
        MakeStopScript "视频解码服务"
    fi
done

echo "设置完成,开始安装 ... "

sed -n -e '1,/^exit 0$/!p' $0 > "${CurrentDir}/SmartVision.tar.gz" 2>/dev/null
TryMkdir ${CurrentDir}/tmp

tar -zxf SmartVision.tar.gz -C ${CurrentDir}/tmp 2>/dev/null
echo "安装服务程序 ... "
MakeBin ${CurrentDir}/tmp/bin
echo "安装依赖库 ... "
MakeLib ${CurrentDir}/tmp/lib
echo "设置配置文件 ... "
MakeCfg ${CurrentDir}/tmp/config

chmod +x ${server_install_path}/bin/*
chmod +x ${server_install_path}/*.sh
rm -rf ${CurrentDir}/tmp
rm -rf SmartVision.tar.gz

if [ "x${key_selected}" == "x" ];then
    ${server_install_path}/bin/GenID.sh ${server_install_path} ${CurrentDir}/id.txt
    touch ${server_install_path}/serial.txt
fi

echo "安装完成, 请使用run_server.sh开始运行程序"
exit 0
