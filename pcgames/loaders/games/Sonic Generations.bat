@echo OFF

set realpath=%~dp0
set exefile="SonicGenerations.exe"
set steamid=steam://rungameid/71340
%realpath%\..\steam-loader.bat %steamid% %exefile%