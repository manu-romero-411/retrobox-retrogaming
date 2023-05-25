#!/usr/bin/env python

import os
import sys
import misc.gamepad_help as ayuda
from misc.get_gamepad_info import getGamepadsInfo
import importlib
import emu.retroarch as rarch
import misc.retroarchGamepadConf as rarchpad
import time

if __name__ == '__main__':
	retroroot = os.path.abspath(os.path.join(os.getcwd(), ".."))
	emudir = os.path.join(retroroot, "emuladores")

	if len(sys.argv) < 2:
		print("[ERROR] Falta argumento: nombre juego")
		exit(1)
	elif len(sys.argv) < 3:
		print("[ERROR] Falta argumento: plataforma")
		exit(1)
	elif len(sys.argv) < 4:
		print("[ERROR] Falta argumento: emulador")
		exit(1)
	elif len(sys.argv) > 5:
		print("[ERROR] Demasiados argumentos")
		exit(1)

	plataforma = sys.argv[2]
	rom = sys.argv[1]
	emu = sys.argv[3]

	#controllersConfig = []
	#for i in range(5, len(sys.argv)):
	#	controllersConfig.append(sys.argv[i])

	gamepadHelp = os.path.join(retroroot, "gamepad-help", plataforma + "_" + os.path.basename(rom) + ".png")

	#print(os.path.exists(gamepadHelp))

	if os.path.exists(gamepadHelp) == False:
		if plataforma == "wii":
			gamepadHelp = os.path.join(retroroot, "gamepad-help", "gamecube" + ".png")
		elif plataforma == "dos":
			gamepadHelp = "none"
		elif plataforma == "scummvm":
			gamepadHelp = "none"
		else:
			gamepadHelp = os.path.join(retroroot, "gamepad-help", plataforma + ".png")
	
	#print(gamepadHelp)
	if os.path.exists(gamepadHelp):
		ayuda.loadImage(gamepadHelp)

	configMandos = rarchpad.getConf()

	if "libretro" in emu:
		rarch.loadGame(rom, plataforma, emu, configMandos)
		os.system("notify-send libretro")

	else:

		emuLoad = importlib.import_module("emu." + emu)
		emuLoad.loadGame(rom,plataforma)

	exit(0)