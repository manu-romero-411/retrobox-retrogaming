@echo off


set realpath=%~dp0
set retroboxroot=%realpath%\..\..
echo " " > D:\.noreboot
taskkill /IM emulationstation.exe  /F
start /b cmd /c %retroboxroot%\misc\Retrobar\Retrobar.exe
sudo pnputil /enable-device "PCI\VEN_10DE&DEV_1299&SUBSYS_18D01043&REV_A1\4&31955350&0&00E0"

exit