@echo off

set realpath=%~dp0
set retroboxroot=%realpath%\..

%retroboxroot%\misc\nircmd.exe win activate stitle "EmulationStation"
exit