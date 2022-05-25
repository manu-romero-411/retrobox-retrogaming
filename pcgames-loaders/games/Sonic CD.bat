@echo OFF

set realpath=%~dp0
set exefile="soniccd.exe"
set steamid=steam://rungameid/200940
%realpath%\..\steam-loader.bat %steamid% %exefile%