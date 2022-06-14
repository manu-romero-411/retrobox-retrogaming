@echo off

set realpath=%~dp0
set exefile="Rayman Legends.exe"
set exedir="D:\Juegos\pcgaming\uplay\Rayman Legends\"
%realpath%\..\epic-uplay-loader.bat %exedir% %exefile%