@echo off &SETLOCAL ENABLEDELAYEDEXPANSION

rem ## DECLARACIÓN DE VARIABLES
set realpath=%~dp0
set rbpath=%realpath%\..\..
set retroboxroot=
pushd %rbpath%
set retroboxroot=%CD%
popd

%retroboxroot%\misc\tools\nircmd.exe win show class Shell_TrayWnd

rem timeout /t 1
rem start %retroboxroot%\misc\tools\RetroBar.exe
