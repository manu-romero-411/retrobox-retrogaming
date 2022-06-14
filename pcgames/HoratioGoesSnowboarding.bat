@echo OFF

set realpath=%~dp0
set exefile="Horatio.exe"
set steamid=steam://rungameid/1589380
%realpath%\loaders\steam-loader.bat %steamid% %exefile%