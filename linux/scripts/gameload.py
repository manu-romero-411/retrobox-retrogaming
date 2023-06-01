#!/usr/bin/env python

import argparse
import os
import os.path as paths
import sys
import misc.gamepad_help as ayuda
import importlib
import emu.retroarch as rarch
import misc.retroarch_gamepad_config as rarchpad
import time

if __name__ == '__main__':
	parser = argparse.ArgumentParser(
		prog='Retrobox game/app loader',
		description='Loads a game or app selected from EmulationStation',
		epilog='Requires rom path, platform, emulator and controllers config')

	gamepadcount = 0
	for i in sys.argv:
		if i == "-p" + str(gamepadcount + 1) + "name":
			gamepadcount = gamepadcount + 1

	parser.add_argument('-rom')
	parser.add_argument('-system')
	parser.add_argument('-emu')

	#i = 0
	#for i in range(1, gamepadcount + 1):
	#	parser.add_argument('-p' + str(i) + 'index')
	#	parser.add_argument('-p' + str(i) + 'name')
	#	parser.add_argument('-p' + str(i) + 'guid')
	#	parser.add_argument('-p' + str(i) + 'nbbuttons')
	#	parser.add_argument('-p' + str(i) + 'nbhats')
	#	parser.add_argument('-p' + str(i) + 'nbaxes')

	args = parser.parse_args()
	arg_list = args._get_kwargs()

	#active_gamepads = []
	#for i in arg_list:
	#	if "guid" in i[0]:
	#		active_gamepads.append(i[1])

	retroroot = paths.abspath(paths.join(paths.dirname(__file__), ".."))
	emudir = os.path.join(retroroot, "emuladores")

	plataforma = args.system
	rom = args.rom
	emu = args.emu

	print("=== CARGANDO JUEGO ===")
	print("rom: " + rom)
	print("sistema: " + plataforma)
	print("emulador: " + emu)
	print("\n")
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

	if "libretro" in emu:
		#gamepad_map = []
		#for i in active_gamepads:
		#	gamepad_map.append(rarchpad.get_gamepad_ids(i))
		#rarch.load_game(rom, plataforma, emu, gamepad_map)
		print("")
	elif "apps" in plataforma:
		import emu.app_loader as webapp
		webapp.load(rom, emu)
	else:
		#emuLoad = importlib.import_module("emu." + emu)
		#emuLoad.load_game(rom, plataforma, active_gamepads)
		print("")
	print("\n")
	exit(0)