#!/usr/bin/env python

import os
import sys
import subprocess
import os.path as paths
import fileinput
import _utilities as utils

def nebula_checkConfig(emuDir, conf):
	if paths.exists(paths.join(emuDir, conf)) == False:
		os.system("cd " + emuDir + " && ln -s ../../saves/segamodel2/" + conf + " " + conf)

def loadGame(rom, plataforma):
	## DECLARACIÓN DE VARIABLES
	retroroot = paths.abspath(paths.join(paths.dirname(__file__), "..", ".."))
	emuDir = os.path.join(retroroot, "emuladores", "model2emu")
	savePath = paths.abspath(paths.join(retroroot, "saves", plataforma))
	wineprefix = paths.join(retroroot, "wineprefix_xp")
	winearch = "win32"

	## COMPROBAR SI LOS DIRECTORIOS DE GUARDADO ESTÁN CORRECTAMENTE PUESTOS
	os.chdir(emuDir)
	nebula_checkConfig(emuDir, "NVDATA")
	nebula_checkConfig(emuDir, "STATES")
	utils.iniEditor(paths.join(emuDir, "EMULATOR.INI"), "Dir1", "Z:" + utils.convert2dosPath(paths.dirname(rom)))

	## CARGAR MODEL2EMU
	subprocess.call(["env", "WINEPREFIX=" + wineprefix, "WINEARCH=" + winearch, "wine", paths.join(emuDir, "EMULATOR.exe"), utils.filename(rom)])
