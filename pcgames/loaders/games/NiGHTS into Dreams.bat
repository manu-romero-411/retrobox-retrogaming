@echo OFF

set realpath=%~dp0
set exefile="Nights.exe"
set steamid=steam://rungameid/219950
%realpath%\..\steam-loader.bat %steamid% %exefile%