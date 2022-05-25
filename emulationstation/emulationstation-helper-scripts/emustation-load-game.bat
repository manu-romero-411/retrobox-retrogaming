@echo off
set realpath=%~dp0
cd %realpath%
set retroboxroot=%realpath%\..\..
if "%1"=="" goto :ERROR
set plataforma=%2
set rom=%2
rem if "%2"=="" goto :ERROR
set CONFIGFILE=%retroboxroot%\old-defaults.conf
set EMUDIR=%retroboxroot%\emuladores
set ROMCONFIGDIR=%retroboxroot%\config\%1-config.conf
set "emu=findstr default-%1 %CONFIGFILE%"

for /f "delims=" %%a in ('%emu%') do (
	set tempvar=%%a
	goto :CONTINUE
)

:CONTINUE
set emu=%tempvar%
echo %emu%
setlocal disabledelayedexpansion
for /f "tokens=1,2 delims==" %%a in ("%emu%") do set emu=%%b

echo %emu% | findstr libretro >NUL && (
	goto :LOADRETROARCH
) || (
	echo %emu% | findstr "scummvm" >NUL && (
		goto :LOADSCUMM
	) || (
    		goto :LOADEXTERNAL
	)
)

:LOADRETROARCH
echo %plataforma% | findstr "saturn" >NUL && (
    goto :LOADRETROARCHSATURN
) || (
    echo %plataforma% | findstr "n64" >NUL && (
        goto :LOADRETROARCHN64
    ) || (
	echo %plataforma% | findstr "psx" >NUL && (
        	goto :LOADRETROARCHPS1
    	) || (
        	goto :LOADRETROARCHNORMAL
	)
    )
)

:LOADSCUMM
cd %EMUDIR%\scummvm\
for /R %rom% %%f in (*.scummvm,*.scummvm2) do (
	%EMUDIR%\scummvm\scummvm.exe -f -p %rom% %%~nf
	goto :EOF
)

%EMUDIR%\scummvm\scummvm.exe -f %rom% 
goto :EOF 

:LOADRETROARCHNORMAL
%EMUDIR%\retroarch\retroarch.exe -L %EMUDIR%\retroarch\cores\%emu%.dll %rom%
goto :EOF

:LOADRETROARCHPS1
%EMUDIR%\retroarch-old\retroarch.exe -L %EMUDIR%\retroarch-old\cores\%emu%.dll %rom%
goto :EOF

:LOADRETROARCHSATURN
for /R %rom% %%f in (*.cue) do (
    %EMUDIR%\retroarch\retroarch.exe -L %EMUDIR%\retroarch\cores\%emu%.dll "%%f"
    goto :EOF
)
goto :EOF

:LOADRETROARCHN64
for %%i in (%rom%) do set baserom="%%~nxi"
FOR /F "tokens=* USEBACKQ" %%F IN (`findstr /C:%baserom% %retroboxroot%\romconfig\n64.txt`) DO (SET var=%%F )
ECHO %var% | findstr mupen64plus_next_libretro && (
	set emu=mupen64plus_next_libretro
)
timeout /t 1
ECHO %%var%% | findstr intel && (
	rem %retroboxroot%\misc\nircmd.exe win hide class Shell_TrayWnd
	%EMUDIR%\retroarch-old\retroarch.exe -c %EMUDIR%\retroarch-old\retroarch-n64.cfg -L %EMUDIR%\retroarch-old\cores\%emu%.dll %rom%
	rem %EMUDIR%\retroarch\retroarch-intel.exe -c %EMUDIR%\retroarch\retroarch-n64.cfg -L %EMUDIR%\retroarch\cores\%emu%.dll %rom%
	goto :EOF
) || (
    %EMUDIR%\retroarch-old\retroarch-old-nvidia.exe -c %EMUDIR%\retroarch-old\retroarch-n64.cfg -L %EMUDIR%\retroarch-old\cores\%emu%.dll %rom%
)
goto :EOF

:PRERETROVENTANAN64
    tasklist|findstr retroarch.exe  || (
        GOTO :RETROVENTANAN64
    )
    timeout /t 3
    GOTO :RUNNING

:RETROVENTANAN64
    tasklist | findstr retroarch.exe  || (
        rem %retroboxroot%\misc\nircmd.exe win show class Shell_TrayWnd
        GOTO :EOF
    )
    timeout /t 3
    GOTO :RETROVENTANAN64

:LOADEXTERNAL
%retroboxroot%\emulationstation\loaders\%emu%.cmd %rom%
goto :EOF

:ERROR
echo ERROR
goto :EOF
