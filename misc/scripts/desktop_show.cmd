@echo off &SETLOCAL ENABLEDELAYEDEXPANSION

rem ## DECLARACIÓN DE VARIABLES
set realpath=%~dp0
set rbpath=%realpath%\..\..
set retroboxroot=
pushd %rbpath%
set retroboxroot=%CD%
popd

reg import %retroboxroot%\misc\regs\iconos-escritorio-mostrar.reg
taskkill /IM explorer.exe /F
start explorer.exe
