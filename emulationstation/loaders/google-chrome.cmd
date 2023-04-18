@echo off &SETLOCAL ENABLEDELAYEDEXPANSION

if [%1]==[] goto :NOARG
set realpath=%~dp0
set rbpath=%realpath%\..\..
set retroboxroot=
pushd %rbpath%
set retroboxroot=%CD%
popd

set chromepath="C:\Program Files\Google\Chrome\Application\chrome.exe"
set chromexec=chrome.exe

tasklist /nh /fi "imagename eq %chromexec%" | find /i "%chromexec%" && taskkill /IM %chromexec% /F
set appfile=%1

SETLOCAL ENABLEDELAYEDEXPANSION
for /F "usebackq tokens=*" %%A in (`type %appfile%`) do (set "app=%%~A")
start /b "" "%retroboxroot%\misc\tools\antimicro\bin\antimicrox.exe" --profile %retroboxroot%\misc\gamepad-profiles\apps-tv.gamecontroller.amgp
%chromepath% --kiosk %app%
timeout /t 1
goto :FIN

:FIN
taskkill /IM antimicrox.exe /F

rem ## DESENGANCHAR TECLA ALT, QUE SE QUEDA COMO "BLOQUEADA"
start /b "" %retroboxroot%\misc\ahks\alt_key_unhang.exe

goto :EOF

:NOARG
echo ERROR: Argumento inválido
goto :EOF
