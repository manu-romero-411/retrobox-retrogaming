@echo OFF

set realpath=%~dp0
set exedir="D:\Juegos\pcgaming\epic\EnterTheGungeon\"
set exefile="EtG.exe"
%realpath%\..\epic-uplay-loader.bat %exedir% %exefile%