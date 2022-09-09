@echo off

if [%1]==[] goto :NOARG
set realpath=%~dp0
set rbpath=%realpath%\..\..
set retroboxroot=
pushd %rbpath%
set retroboxroot=%CD%
popd

REM set chromepath="C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
REM set chromexec=msedge.exe

set chromepath="C:\Program Files\Google\Chrome\Application\chrome.exe"
set chromexec=chrome.exe

tasklist /nh /fi "imagename eq %chromexec%" | find /i "%chromexec%" && taskkill /IM %chromexec% /F
set appfile=%1
findstr kodi %appfile% && (
	goto :KODI
) || (
	findstr steam %appfile% && (
		goto :STEAM
	) || (
		findstr discord %appfile% && (
			goto :DISCORD
		) || (
			findstr google-chrome %appfile% && (
				goto :CHROME
			) || (
				findstr telegram %appfile% && (
					goto :TELEGRAM
				) || (
					goto :WEBAPP
				)
			)
		)
	)
)

:CHROME
start /b cmd /c  "C:\Program Files\AntimicroX\bin\antimicrox.exe" --profile %retroboxroot%\gamepad-profiles\apps-tv.gamecontroller.amgp
%chromepath% /high-dpi-support=1 /force-device-scale-factor=1.50
timeout /t 2
goto :CHROMEISLAUNCHED

:KODI
%realpath%\kodi.cmd
goto :EOF

:STEAM
%realpath%\steam.cmd
goto :EOF

:DISCORD
%realpath%\discord.cmd
goto :EOF

:TELEGRAM
%realpath%\telegram.cmd
goto :EOF

:WEBAPP
SETLOCAL ENABLEDELAYEDEXPANSION
for /F "usebackq tokens=*" %%A in (`type %appfile%`) do (set "app=%%~A")
start /b cmd /c "C:\Program Files\AntimicroX\bin\antimicrox.exe" --profile %retroboxroot%\gamepad-profiles\apps-tv.gamecontroller.amgp
%chromepath% --kiosk %app%
timeout /t 1
goto :FIN

:CHROMEISLAUNCHED
tasklist /nh /fi "imagename eq %chromexec%" | find /i "%chromexec%" && (
 	goto :WHILE
) || (
	goto :FIN
)

:NOTWHILE
tasklist /nh /fi "imagename eq %chromexec%" | find /i "%chromexec%" && (
 	goto :WHILE
) || (
	timeout /t 3
	goto :NOTWHILE
)

:WHILE
tasklist /nh /fi "imagename eq %chromexec%" | find /i "%chromexec%" && (
	timeout 4
 	goto :WHILE
) || (
	goto :FIN
)

:KILLKODI
taskkill /IM ace_engine.exe /F
taskkill /IM ace_update.exe /F
taskkill /IM antimicrox.exe /F
goto :EOF

:FIN
taskkill /IM antimicrox.exe /F

rem ## DESENGANCHAR TECLA ALT, QUE SE QUEDA COMO "BLOQUEADA"
start /b cmd /c %retroboxroot%\misc\ahks\alt_key_unhang.exe
timeout /t 1

goto :EOF

:NOARG
echo ERROR: Argumento inválido
goto :EOF
