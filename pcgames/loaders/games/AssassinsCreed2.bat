@echo off

set realpath=%~dp0
set exefile="AssassinsCreedIIGame.exe"
set exedir="D:\Juegos\pcgaming\uplay\Assassin's Creed II\"
%realpath%\..\epic-uplay-loader.bat %exedir% %exefile%