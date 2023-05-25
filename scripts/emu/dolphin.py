#!/usr/bin/env python

import os
import os.path as paths
import sys
import _utilities as utils

def loadGame(rom, plataforma):
	retroroot = paths.abspath(paths.join(paths.dirname(__file__), "..", ".."))
	#emuDir = os.path.join(retroroot, "emuladores", "cemu")
	savePath = paths.abspath(paths.join(retroroot, "saves", plataforma))
	dolphin_exec = "/usr/bin/flatpak run --branch=stable --arch=x86_64 --command=/app/bin/dolphin-emu-wrapper org.DolphinEmu.dolphin-emu"
	dolphin_args = "-b -e " + utils.addQuotes(rom)

	os.system(dolphin_exec + " " + dolphin_args)


