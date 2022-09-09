@echo off

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
	tasklist|findstr %exefile% && (
		timeout /t 4
		goto :LOOP
    	) || (
		cmd /c %retroboxroot%\misc\emustation-focus.cmd
        	goto :EOF
    	)