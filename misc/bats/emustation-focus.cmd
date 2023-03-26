@echo off &SETLOCAL ENABLEDELAYEDEXPANSION

set realpath=%~dp0
set retroboxroot=%realpath%\..
timeout /t 2

%retroboxroot%\misc\nircmd.exe win activate stitle "EmulationStation"
exit