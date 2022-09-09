@echo off

rem ## VARIABLES DE ENTORNO
set realpath=%~dp0
set rbpath=%realpath%\..\..
set retroboxroot=
pushd %rbpath%
set retroboxroot=%CD%
popd

%retroboxroot%/misc/tools/SilentCMD.exe %retroboxroot%/misc/scripts/reboot-linux.cmd