@echo on &SETLOCAL ENABLEDELAYEDEXPANSION

set realpath=%~dp0
cd %realpath%
set rbpath=%realpath%\..\..\..
set retroboxroot=
pushd %rbpath%
set retroboxroot=%CD%
popd

set exefile=Minecraft.Windows.exe

start %realpath%\lnk\Minecraft.lnk

:LOOP
tasklist | findstr %exefile%
if NOT errorlevel 1 (
	timeout /t 4
	goto :LOOP
)

exit 0