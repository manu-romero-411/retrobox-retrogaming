@echo on

set realpath=%~dp0
set retroboxroot=%realpath%\..\..\..\..
%retroboxroot%\misc\nircmd.exe sendmouse move 2000 2000
%retroboxroot%\extra-menus\pcgames\loaders\games\lnk\sonicTripleTrouble.lnk
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