@echo off


rem ## VARIABLES DE ENTORNO
set realpath=%~dp0
set rbpath=%realpath%\..\..
set retroboxroot=
pushd %rbpath%
set retroboxroot=%CD%
popd

start %retroboxroot%\misc\tools\XOutput\xoutput.lnk
exit 0