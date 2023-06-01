#!/usr/bin/env python

import os
import os.path as paths
from misc import _utilities as utils

def load_game(rom, plataforma, active_gamepads):
	retroroot = paths.abspath(paths.join(paths.dirname(__file__), "..", ".."))
	emu_dir = os.path.join(retroroot, "emuladores", "ppsspp")
	emu_saves = paths.join(retroroot, "saves", plataforma)
	emu_conf_dir = paths.join(emu_saves, "SYSTEM")
	emu_conf_file = paths.join(emu_conf_dir, "ppsspp.ini")

	emu_exec = "/usr/bin/flatpak run --branch=stable --arch=x86_64 --command=PPSSPPSDL org.ppsspp.PPSSPP"
	emu_args = utils.addQuotes(rom)

	os.system(emu_exec + " " + emu_args)


