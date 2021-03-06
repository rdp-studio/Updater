@echo off
setlocal EnableExtensions EnableDelayedExpansion

if not defined jz.branches set "jz.branches=master"
if not defined jz.appname set "jz.appname=AppInstaller"
if not defined jz.ver set "jz.ver=0"
if not defined dir.jz.temp set "dir.jz.temp=%temp%\JZUpdater"
if not exist %dir.jz.temp% mkdir %dir.jz.temp%
set jz.urlfix.1=https://raw.githubusercontent.com/rdp-studio/Updater/!jz.branches!
set jz.insini.urldir=Server/%jz.appname%/ver.ini

:: 加载个语言包
set txt_vc.loading=^>^>^>^> 正在准备...

call :clearscreen

:: 删掉临时文件
>nul 2>nul ( dir "%dir.jz.temp%\ver.ini" /a:-d /b && del /q /f /s "%dir.jz.temp%\ver.ini" )
:: 下载版本控制文件
call :psdl "!jz.insini.urldir!" "%dir.jz.temp%\ver.ini"
if "!ERRORLEVEL!"=="1" exit /b
:: 读取版本控制文件
for /f "eol=[ usebackq tokens=1,* delims==" %%a in (`type "%dir.jz.temp%\ver.ini"`) do set "%%a=%%b"
if /i "%jz.newver%"=="%jz.ver%" exit /b
:: 加载个语言包
set txt_vc.loading=^>^>^>^> 正在更新/安装...
:: 清屏
call :clearscreen
:: 下载版本文件
call :psdl "!jz.apppack.urldir!" "%dir.jz.temp%\%jz.apppack.pag%" "%jz.apppack.sha1%"
if "!ERRORLEVEL!"=="1" exit /b
:: 判断类型，自动安装（也顺便结束下进程）
taskkill /f /im %jz.apppack.kill%
if %jz.apppack.type%==msix goto :msixinstall
if %jz.apppack.type%==exe goto :exeinstall
exit /b

:: Msix安装
:msixinstall
powershell Add-AppxPackage "%dir.jz.temp%\%jz.apppack.pag%"
echo start shell:AppsFolder\%jz.apppack.msix.bundleid%^^!%jz.apppack.msix.entryname%^&exit>%dir.jz.temp%\temp.bat
start cmd /c %dir.jz.temp%\temp.bat
exit /b

:: Exe安装
:exeinstall
"%dir.jz.temp%\%jz.apppack.pag%"
start %jz.apppack.exe.entrypoint%
exit /b

exit /b

:: 插件
:MsgBox
mshta vbscript:execute^("msgbox(""%~1""&vbCrLf&vbCrLf&""%~2"",64+4096)(close)"^)
exit /b

:clearscreen
cls
echo JZUpdater v1.0.0.1
echo Copyright (C) 2019-2021 RDPStudio All rights reversed.
exit /b

:psdl
for /f "tokens=1,* delims==" %%a in ('set jz.urlfix.') do (
	<nul set /p ="%txt_vc.loading%"
	2>nul powershell "&{(new-object System.Net.WebClient).DownloadFile('%%~b/%~1', '%~2')}"
	if "%~3"=="" (
		>nul 2>nul dir "%~2" /a:-d /b && exit /b 0
	) else (
		for /f "skip=1 tokens=* delims=" %%i in ('certutil -hashfile "%~2" SHA1') do (
			set "ctt=%%i" & echo;"ctt=!ctt: =!" | >nul findstr "\<%~3\>" && exit /b 0
		)
	)
	set "%%a="
)
exit /b 1