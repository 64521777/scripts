@echo off
:: �û��ļ���
Set USR=xxy
:: �˹���ѡͼ��Ĵ��·��
SET MANUAL_PICK_DATA_DIR=%cd%\�˹�����
:: �ϴ�����������·��
SET SERVER_SAVE_DIR=\\192.168.142.200\smart\shxq\developer\finetune_work\raw_image\%USR%

:: �����������ļ���
for /F %%i in ('dir %MANUAL_PICK_DATA_DIR% /ad /b') do (
    echo "Processing Dir: %%i"
	if not exist %SERVER_SAVE_DIR%\%%i (
	    md %SERVER_SAVE_DIR%\%%i )	
	:: �ƶ��ļ���������
	for /r "%MANUAL_PICK_DATA_DIR%\" %%j in (%%i\*.*) do (
	    echo %%j
		move %%j %SERVER_SAVE_DIR%/%%i
	)
)
echo "�����ϴ����"
pause
