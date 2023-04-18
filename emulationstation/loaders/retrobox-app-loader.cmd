@echo off &SETLOCAL ENABLEDELAYEDEXPANSION

if [%1]==[] goto :NOARG
if [%2]==[] goto :NOARG
set realpath=%~dp0
set rbpath=%realpath%\..\..
set retroboxroot=
pushd %rbpath%
set retroboxroot=%CD%
popd

if [%2]==[] goto :CONTINUA
%realpath%\%2.cmd %1
goto :EOF

:CONTINUA
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

:KILLKODI
taskkill /IM ace_engine.exe /F
taskkill /IM ace_update.exe /F
taskkill /IM antimicrox.exe /F
goto :EOF

:FIN
taskkill /IM antimicrox.exe /F

rem ## DESENGANCHAR TECLA ALT, QUE SE QUEDA COMO "BLOQUEADA"
start /b "" %retroboxroot%\misc\ahks\alt_key_unhang.exe
goto :EOF

:NOARG
echo ERROR: Argumento inválido
goto :EOF
