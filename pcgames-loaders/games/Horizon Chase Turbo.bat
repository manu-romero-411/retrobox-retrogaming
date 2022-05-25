@echo OFF

set realpath=%~dp0
set exedir="D:\Juegos\pcgaming\epic\HorizonChaseTurbo\"
set exefile="HorizonChase.exe"
%realpath%\..\epic-uplay-loader.bat %exedir% %exefile%