@echo off
:: 用户文件夹
Set USR=xxy
:: 人工挑选图像的存放路径
SET MANUAL_PICK_DATA_DIR=%cd%\人工分类
:: 上传到服务器的路径
SET SERVER_SAVE_DIR=\\192.168.142.200\smart\shxq\developer\finetune_work\raw_image\%USR%

:: 遍历所有子文件夹
for /F %%i in ('dir %MANUAL_PICK_DATA_DIR% /ad /b') do (
    echo "Processing Dir: %%i"
	if not exist %SERVER_SAVE_DIR%\%%i (
	    md %SERVER_SAVE_DIR%\%%i )	
	:: 移动文件到服务器
	for /r "%MANUAL_PICK_DATA_DIR%\" %%j in (%%i\*.*) do (
	    echo %%j
		move %%j %SERVER_SAVE_DIR%/%%i
	)
)
echo "数据上传完成"
pause
