@echo off

rem ## DECLARACIÓN DE VARIABLES
set realpath=%~dp0
set rbpath=%realpath%\..\..
set retroboxroot=
pushd %rbpath%
set retroboxroot=%CD%
popd

set plat=%1
set rom=%2

for /F "delims=" %%i in ("%rom:"=%") do set basename="%%~ni"
echo %retroboxroot:"=%\misc\mandoHelp\%plat:"=%_%basename:"=%.png
rem copy "%retroboxroot:"=%\misc\mandoHelp\placeholder_comicsans.png" "%retroboxroot:"=%\misc\mandoHelp\%plat:"=%_%basename:"=%.png"
if exist "%retroboxroot:"=%\misc\mandoHelp\%plat:"=%_%basename:"=%.png" (
	set help="%plat:"=%_%basename:"=%"
) else (
	if %plat%==wii GOTO :WII
	if %plat%==dos GOTO :NONE
	if %plat%==scummvm GOTO :NONE
	set help=%plat%
)
goto :eof

:WII
set help=gamecube
goto :eof