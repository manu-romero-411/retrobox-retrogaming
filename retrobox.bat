@echo off

rem ## DECLARACIÓN DE VARIABLES
set realpath=%~dp0
set retroboxroot=%realpath%

rem ## SI NO EXISTE UN .winboot EN C:\, SE DEBERÁ CARGAR EL ENTORNO DE RETROBOX DESDE EL MENÚ INICIO.
rem ## EL ARCHIVO .winboot SE GENERA DESDE EL SISTEMA LINUX PRINCIPAL DEL PC. CONTROLA EL DESVÍO DEL ARRANQUE DE GRUB Y EL INICIO AUTOMÁTICO DE EMULATIONSTATION.
if not exist C:\.winboot (
	if "%1" == "-b" (
		goto :EOF
	)
)

rem ## EL ARCHIVO .noreboot ES GENERADO SI USAMOS LA OPCIÓN "Modo Windows" DEL MENÚ "Opciones del sistema".
REM ## IMPIDE QUE SE VUELVA A LINUX AL SELECCIONAR TAL OPCIÓN.
del D:\.noreboot

rem ## ÚNICA INSTANCIA: SI SE INTENTA EJECUTAR UNA SEGUNDA INSTANCIA DEL SCRIPT, NO PASARÁ NADA.
tasklist /nh /fi "imagename eq emulationstation.exe" | find /i "emulationstation.exe" && exit 1
REM tasklist /nh /fi "imagename eq retrobat.exe" | find /i "retrobat.exe" && exit
REM tasklist /nh /fi "imagename eq retroarch.exe" | find /i "retroarch.exe" && exit

rem ## PARA AHORRAR ENERGÍA Y QUE EL PC NO SE CALIENTE MÁS DE LA CUENTA, APAGAR GRÁFICA NVIDIA (SE ENCENDERÁ SI ES NECESARIO EN ALGÚN JUEGO/EMULADOR).
sudo pnputil /disable-device "PCI\VEN_10DE&DEV_1299&SUBSYS_18D01043&REV_A1\4&31955350&0&00E0"

rem ## SI CARGAMOS RETROBOX DESDE EL MODO WINDOWS, CERRAR LAS INTERFACES DEL MODO WINDOWS.
if NOT "%1" == "-b" (
	taskkill /IM Retrobar.exe /F
	%retroboxroot%\misc\nircmd.exe win show class Shell_TrayWnd
	sudo powershell -command "&{$p='HKCU:SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StuckRects3';$v=(Get-ItemProperty -Path $p).Settings;$v[8]=2;&Set-ItemProperty -Path $p -Name Settings -Value $v;&Stop-Process -f -ProcessName explorer}"
	timeout /t 2
)

rem ## OCULTAR BARRA DE TAREAS DE WINDOWS COMPLETAMENTE
%retroboxroot%\misc\nircmd.exe win hide class Shell_TrayWnd

rem ## BUCLE DE EJECUCIÓN
:RUN
	rem ## INICIAR EMULATIONSTATION
	start /w %retroboxroot%\emulationstation\emulationstation.exe
	
	rem ## RUTINA DE FINALIZACIÓN DE EMULATIONSTATION
	goto :FIN

rem ## BUCLE DE CIERRE
:FIN
	rem ## SI HAY UN ARCHIVO .winboot, QUERRÁ DECIR QUE HEMOS INICIADO DESDE LINUX. SE INTENTA VOLVER A LINUX.
	if exist C:\.winboot (
		rem ### SI HEMOS CERRADO EMULATIONSTATION DESDE LA OPCIÓN "Modo Windows", SE CREARÁ EL ARCHIVO .noreboot.
		rem ### DE LO CONTRARIO, AL LLEGAR AQUÍ, VOLVEREMOS A LINUX (BIEEEEEN).
		if not exist C:\.noreboot (
			%retroboxroot%\misc\silentcmd-windows\SilentCMD.exe %retroboxroot%\misc\reboot-linux.bat
		)
	)
