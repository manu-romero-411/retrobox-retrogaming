@echo off

rem ## DECLARACIÓN DE VARIABLES
set realpath=%~dp0
set rbpath=%realpath%\..\..
set retroboxroot=
pushd %rbpath%
set retroboxroot=%CD%
popd

del D:\.winboot
del D:\.wingaming
del D:\.noreboot
%retroboxroot%\misc\tools\reboot.lnk