@echo off
rem ## DECLARACIÓN DE VARIABLES
set realpath=%~dp0
set rbpath=%realpath%\..\..
set retroboxroot=
pushd %rbpath%
set retroboxroot=%CD%
popd

if %1 == 054c0268 (
	tasklist |findstr "XOutput" && (
		if %2 == -d (
			taskkill /IM XOutput.exe /F
		)
	) || (
		start "" "%retroboxroot%\misc\tools\XOutput\XOutput.exe"  --minimized
	)
	exit 0
) else (
	exit 1
)

