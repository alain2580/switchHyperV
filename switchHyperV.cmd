@echo off
cd /d %~dp0

openfiles > nul 2>&1
if "%ERRORLEVEL%" == "1" (
    echo.
    echo �Ǘ��Ҍ����ŋN�����s���܂�...
    echo.
    powershell start-process %~nx0 -verb runas
    exit
)

bcdedit | find "hypervisorlaunchtype" > %~nx0.tmp
findstr "Auto" %~nx0.tmp > nul
if "%ERRORLEVEL%" == "0" (
    set RESULT=enable
) else (
    set RESULT=disable
)
del %~nx0.tmp

if "%RESULT%" == "enable" (
    echo.
    echo ���݁AHyper-V��[ �L�� ]�ł��B
    echo Hyper-V�𖳌����āAWindows�̍ċN�����s���܂��B
    echo.
    pause
    bcdedit /set hypervisorlaunchtype off
) else (
    echo.
    echo ���݁AHyper-V��[ ���� ] �ł��B
    echo Hyper-V��L�����āAWindows�̍ċN�����s���܂��B
    echo.
    pause
    bcdedit /set hypervisorlaunchtype auto
)

shutdown /r /f /t 1
