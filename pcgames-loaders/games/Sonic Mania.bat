@echo OFF

set realpath=%~dp0
set exedir="D:\Juegos\pcgaming\epic\SonicMania\"
set exefile="SonicMania.exe"
%realpath%\..\epic-uplay-loader.bat %exedir% %exefile%