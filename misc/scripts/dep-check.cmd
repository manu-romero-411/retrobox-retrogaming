@echo on

rem ## ESTE SCRIPT CONTROLARÁ QUE TODAS LAS DEPENDENCIAS DE RETROBOX ESTÉN EN SU CARPETA CORRECTAMENTE

rem ## DECLARACIÓN DE VARIABLES
set realpath=%~dp0
set rbpath=%realpath%\..\..
set retroboxroot=
pushd %rbpath%
set retroboxroot=%CD%
popd

for /f "tokens=3* delims= " %%a in ('reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /v "Desktop"') do (set escritorio=%%a %%b)
set "escritorio=%escritorio:~0,-1%"

if exist %escritorio%\retrobox-deps.txt (
    del %escritorio%\retrobox-deps.txt
)

for %%d in (inifile.exe nircmd.exe SilentCMD.exe Sleep.exe sed.exe) do (
    if NOT EXIST %retroboxroot%\misc\tools\%%d (
        echo dependencia faltante - herramienta: %%d >> %escritorio%\retrobox-deps.txt
    )
)

    if NOT EXIST %retroboxroot%\misc\tools\antimicro\bin\antimicrox.exe (
        echo dependencia faltante - herramienta: antimicrox >> %escritorio%\retrobox-deps.txt
    )

if NOT EXIST "C:\Program Files\Kodi\kodi.exe" (
    echo dependencia faltante - herramienta: kodi >> %escritorio%\retrobox-deps.txt
)

if NOT EXIST "%appdata%\ACEStream\engine\ace_engine.exe" (
    echo dependencia faltante - herramienta: acestream >> %escritorio%\retrobox-deps.txt
)

for %%d in ("cemu\Cemu.exe" "retroarch\retroarch.exe" "pcsx2\pcsx2x64-avx2.exe" "dolphin\Dolphin.exe" "model2emu\EMULATOR.EXE" "ppsspp\PPSSPPWindows.exe" "redream\redream.exe") do (
    if NOT EXIST %retroboxroot%\emuladores\%%d (
        echo dependencia faltante - emulador: %%d>> %escritorio%\retrobox-deps.txt
    )
)
