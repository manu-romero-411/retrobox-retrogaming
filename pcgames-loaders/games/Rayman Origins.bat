@echo off

set realpath=%~dp0
set exefile="Rayman Origins.exe"
set exedir="D:\Juegos\pcgaming\uplay\Rayman Origins\"
%realpath%\..\epic-uplay-loader.bat %exedir% %exefile%