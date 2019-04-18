@echo off
cd /d %~dp0

openfiles > nul 2>&1
if "%ERRORLEVEL%" == "1" (
    echo.
    echo 管理者権限で起動を行います...
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
    echo 現在、Hyper-Vは[ 有効 ]です。
    echo Hyper-Vを無効して、Windowsの再起動を行います。
    echo.
    pause
    bcdedit /set hypervisorlaunchtype off
) else (
    echo.
    echo 現在、Hyper-Vは[ 無効 ] です。
    echo Hyper-Vを有効して、Windowsの再起動を行います。
    echo.
    pause
    bcdedit /set hypervisorlaunchtype auto
)

shutdown /r /f /t 1
