@echo on

rem ## DECLARACIÓN DE VARIABLES
set realpath=%~dp0
set rbpath=%realpath%
set retroboxroot=
pushd %rbpath%
set retroboxroot=%CD%
popd

rem ## SI NO EXISTE UN .winboot EN C:\, SE DEBERÁ CARGAR EL ENTORNO DE RETROBOX DESDE EL MENÚ INICIO.
rem ## EL ARCHIVO .winboot SE GENERA DESDE EL SISTEMA LINUX PRINCIPAL DEL PC. CONTROLA EL DESVÍO DEL ARRANQUE DE GRUB Y EL INICIO AUTOMÁTICO DE EMULATIONSTATION.
if not exist D:\.wingaming (
	if "%1" == "-b" (
		goto :EOF
	)
)

rem ## EL ARCHIVO .noreboot ES GENERADO SI USAMOS LA OPCIÓN "Modo Windows" DEL MENÚ "Opciones del sistema".
REM ## IMPIDE QUE SE VUELVA A LINUX AL SELECCIONAR TAL OPCIÓN.
del D:\.noreboot

rem ## ÚNICA INSTANCIA: SI SE INTENTA EJECUTAR UNA SEGUNDA INSTANCIA DEL SCRIPT, NO PASARÁ NADA.
tasklist /nh /fi "imagename eq emulationstation.exe" | find /i "emulationstation.exe" && exit 1

rem ## PARA AHORRAR ENERGÍA Y QUE EL PC NO SE CALIENTE MÁS DE LA CUENTA, APAGAR GRÁFICA NVIDIA (SE ENCENDERÁ SI ES NECESARIO EN ALGÚN JUEGO/EMULADOR).
rem pnputil /disable-device "PCI\VEN_10DE&DEV_1299&SUBSYS_18D01043&REV_A1\4&31955350&0&00E0"

rem ## OCULTAR BARRA DE TAREAS E ICONOS DEL ESCRITORIO DE WINDOWS COMPLETAMENTE
if NOT "%1" == "-b" (
	powershell -command "(New-Object -comObject Shell.Application).Windows() | foreach-object {$_.quit()}; Get-Process | Where-Object {$_.MainWindowTitle -ne \"\"} | stop-process"
)

reg import %retroboxroot%\misc\regs\iconos-escritorio-ocultar.reg
taskkill /IM explorer.exe /F
start explorer.exe
timeout /t 5
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
	if exist D:\.wingaming (
		rem ### SI HEMOS CERRADO EMULATIONSTATION DESDE LA OPCIÓN "Modo Windows", SE CREARÁ EL ARCHIVO .noreboot.
		rem ### DE LO CONTRARIO, AL LLEGAR AQUÍ, VOLVEREMOS A LINUX (BIEEEEEN).
		if not exist D:\.noreboot (
			%retroboxroot%\misc\tools\SilentCMD.exe %retroboxroot%\misc\reboot-linux.bat
		) else (
			del D:\.noreboot
			del D:\.wingaming
		)
	)

	
	%retroboxroot%\misc\nircmd.exe win show class Shell_TrayWnd
	reg import %retroboxroot%\misc\regs\iconos-escritorio-mostrar.reg
	taskkill /IM explorer.exe /F
	start explorer.exe