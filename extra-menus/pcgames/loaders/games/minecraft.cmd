@echo off
set realpath=%~dp0
cd %realpath%
set retroboxroot=%realpath%..\..\..\..
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