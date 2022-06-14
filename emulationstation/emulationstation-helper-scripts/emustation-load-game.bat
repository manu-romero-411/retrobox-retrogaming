@echo on
set realpath=%~dp0
cd %realpath%
set retroboxroot=%realpath%\..\..
if "%1"=="" goto :ERROR
set plataforma=%1
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
if exist "E:\Juegos\saves\%plataforma%" ( 
	echo a
) else (
	mkdir "E:\Juegos\saves\%plataforma%"
)

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
del %EMUDIR%\retroarch\retroarch-config.cfg
copy %EMUDIR%\retroarch\retroarch-original.cfg %EMUDIR%\retroarch\retroarch-config.cfg
cscript %retroboxroot%\misc\replace.vbs %EMUDIR%\retroarch\retroarch-config.cfg "directorio" "E:\Juegos\saves\%plataforma%"
%EMUDIR%\retroarch\retroarch.exe -c %EMUDIR%\retroarch\retroarch-config.cfg -L %EMUDIR%\retroarch\cores\%emu%.dll %rom%
goto :EOF

:LOADRETROARCHPS1
del %EMUDIR%\retroarch-old\retroarch-config.cfg
copy %EMUDIR%\retroarch-old\retroarch-original.cfg %EMUDIR%\retroarch-old\retroarch-config.cfg
cscript %retroboxroot%\misc\replace.vbs %EMUDIR%\retroarch-old\retroarch-config.cfg "directorio" "E:\Juegos\saves\%plataforma%"
%EMUDIR%\retroarch-old\retroarch.exe -c %EMUDIR%\retroarch-old\retroarch-config.cfg -L %EMUDIR%\retroarch-old\cores\%emu%.dll %rom%
goto :EOF

:LOADRETROARCHSATURN
del %EMUDIR%\retroarch-old\retroarch-config.cfg
copy %EMUDIR%\retroarch-old\retroarch-original.cfg %EMUDIR%\retroarch-old\retroarch-config.cfg
cscript %retroboxroot%\misc\replace.vbs %EMUDIR%\retroarch-old\retroarch-config.cfg "directorio" "E:\Juegos\saves\%plataforma%"

for /R %rom% %%f in (*.cue) do (
    %EMUDIR%\retroarch-old\retroarch.exe -c %EMUDIR%\retroarch-old\retroarch-config.cfg -L %EMUDIR%\retroarch-old\cores\%emu%.dll "%%f"
    goto :EOF
)
goto :EOF

:LOADRETROARCHN64
del %EMUDIR%\retroarch-old\retroarch-config.cfg
rem copy %EMUDIR%\retroarch-old\retroarch-n64-original.cfg %EMUDIR%\retroarch-old\retroarch-n64.cfg
rem cscript %retroboxroot%\misc\replace.vbs %EMUDIR%\retroarch-old\retroarch-n64.cfg "directorio" "E:\Juegos\saves\%plataforma%"

for %%i in (%rom%) do set baserom="%%~nxi"
FOR /F "tokens=* USEBACKQ" %%F IN (`findstr /C:%baserom% %retroboxroot%\romconfig\n64.txt`) DO (SET var=%%F )
ECHO %var% | findstr mupen64plus_next_libretro && (
	set emu=mupen64plus_next_libretro
)
rem timeout /t 1
ECHO %var% | findstr intel && (
	%EMUDIR%\retroarch-old\retroarch.exe -c %EMUDIR%\retroarch-old\retroarch-n64.cfg -L %EMUDIR%\retroarch-old\cores\%emu%.dll %rom%
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
