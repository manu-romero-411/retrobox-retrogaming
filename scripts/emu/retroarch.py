#!/usr/bin/env python

import os
import sys
import subprocess
import os.path as paths
import fileinput
import _utilities as utils
import misc.retroarchGamepadConf as rarchpad

def loadGame(rom, plataforma, emu, configMandos):
	## DECLARACIÓN DE VARIABLES
	retroroot = paths.abspath(paths.join(paths.dirname(__file__), "..", ".."))

	savePath = paths.abspath(paths.join(retroroot, "saves", plataforma))
	biosPath = paths.abspath(paths.join(retroroot, "bios"))

	emuDir = os.path.join(retroroot, "emuladores", "retroarch")
	emuConfDir = os.path.join(emuDir, "retroarch.AppImage.home", ".config", "retroarch")

	## CREAR DIRECTORIO DE GUARDADO DE PARTIDAS SI NO EXISTE
	if paths.exists(savePath) == False:
		os.mkdir(savePath)

	## CONFIGURAR DIRECTORIO DE GUARDADO EN RETROARCH
	retroarchCfg = paths.join(emuConfDir, "retroarch.cfg")
	utils.iniEditor_spaces(retroarchCfg, "system_directory", biosPath)
	utils.iniEditor_spaces(retroarchCfg, "savefile_directory", savePath)

	## CONFIGURAR MANDOS
	rarchpad.setConf(retroarchCfg, configMandos)

	## CARGAR RETROARCH
	coreName = paths.join(emuConfDir, "cores", emu + ".so")

	subprocess.call([paths.join(emuDir, "retroarch.AppImage"), "-L", coreName, rom])

	## DESHACER CONFIGURACIÓN DE DIRECTORIO DE GUARDADO
	utils.iniEditor_spaces(retroarchCfg, "savefile_directory", paths.abspath(paths.join(savePath, "..")))

#print(coreName)
