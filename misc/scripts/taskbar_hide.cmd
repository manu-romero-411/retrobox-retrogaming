@echo off &SETLOCAL ENABLEDELAYEDEXPANSION

rem ## DECLARACIÓN DE VARIABLES
set realpath=%~dp0
set rbpath=%realpath%\..\..
set retroboxroot=
pushd %rbpath%
set retroboxroot=%CD%
popd

taskkill /IM RetroBar.exe /F
timeout /t 2
%retroboxroot%\misc\tools\nircmd.exe win hide class Shell_TrayWnd
