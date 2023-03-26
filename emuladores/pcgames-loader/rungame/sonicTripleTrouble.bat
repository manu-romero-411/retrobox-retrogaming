@echo off &SETLOCAL ENABLEDELAYEDEXPANSION

set realpath=%~dp0
set rbpath=%realpath%\..\..\..
set retroboxroot=
pushd %rbpath%
set retroboxroot=%CD%
popd

%retroboxroot%\misc\tools\nircmd.exe sendmouse move 2000 2000
%realpath%\lnk\sonicTripleTrouble.lnk
goto :EOF

:PRELOOP
	tasklist | findstr "Sonic" && (
		goto :LOOP
	) || (
		sleep 2
		goto :PRELOOP
	)
:LOOP
	tasklist | findstr "Sonic" && (
		%retroboxroot%\misc\nircmd.exe sendmouse move 2000 2000
		timeout /t 4
		goto :LOOP
	) || (
		goto :EOF
	)