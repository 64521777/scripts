算法打包分布程序 - ubuntu14.04, 开发使用
算法对外安装包 - 测试、发布使用:\\192.168.142.199\Public\项目系统&组件 安装脚本\常用组件类--只支持ubuntu\算法模块\广电-色情+指纹+人脸+视频解码
1. bin -- 用到的二进制和脚本
2. config -- 用到的服务配置和模型数据
3. lib -- 依赖库
4. InstallAlg.sh -- 安装脚本
5. AlgPkg.sh -- 打包程序

使用方法：
1. 打包： 执行命令: ./AlgPkg.sh
          脚本将bin,config,lib文件压缩成压缩包，然后把脚本InstallAlg.sh和压缩包写成一个instal.bin安装文件
          生成的install.bin为算法发布的安装包
2. 安装： 赋予install.bin可执行权限:chmod +x install.bin
          执行./install.bin
          按照程序提示设置参数，完成安装
          
程序说明：
1. bin:    *_NK格式的程序为NO_KEY程序
           *_RD格式为使用视频远端解码的程序
           VideoDecoderServer为解码程序
           VideoDecoderTool为解码工具程序
           runVideoDecode.sh调用解码工具程序脚本，被解码服务调用。涉及环境变量问题，故用脚本调用
2. config: data为所有用到模型数据,内部使用
           module为系统各个模块的具体配置
           *.prototxt为各个服务的配置
3. lib:  程序依赖库

安装说明：
1. 启动和关闭脚本： ./install.bin执行完成后会自动根据安装参数生成在安装目录下run_server.sh和stop_server.sh
2. KEY版本会在当前目录下生成id.txt,用于生成序列号. 填写到安装目录下./serial.txt



