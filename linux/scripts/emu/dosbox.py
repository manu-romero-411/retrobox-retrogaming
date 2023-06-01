#!/usr/bin/env python

import os
import os.path as paths
from misc import _utilities as utils

def load_game(rom, plataforma, active_gamepads):
	retroroot = paths.abspath(paths.join(paths.dirname(__file__), "..", ".."))
	emu_dir = os.path.join(retroroot, "emuladores", "dosbox")
	emu_config = paths.join(emu_dir, "doscfg.conf")
	emu_save_path = paths.abspath(paths.join(retroroot, "saves", plataforma))
	emu_exec = "/usr/bin/dosbox"
	emu_args = "-userconf -conf " + emu_config

	utils.replace(emu_config, "directorio1", utils.addQuotes(rom))
	os.system(emu_exec + " " + emu_args)
	utils.replace(emu_config, utils.addQuotes(rom), "directorio1")
