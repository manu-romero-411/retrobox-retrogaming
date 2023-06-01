#!/usr/bin/env python

import os
import subprocess
import os.path as paths
from misc import _utilities as utils

def flash_parse_game(dir):
    with open(dir + "/flash.conf", "r") as infile:
        return dir + "/" + infile.readline().split("=")[1].split(".swf")[0] + ".swf"

def load_game(rom, plataforma, active_gamepads):
    ## DECLARACIÓN DE VARIABLES
    retroroot = paths.abspath(paths.join(paths.dirname(__file__), "..", ".."))
    emu_dir = os.path.join(retroroot, "emuladores", "flash")
    #savePath = paths.abspath(paths.join(retroroot, "saves", plataforma))
    wineprefix = paths.join(retroroot, "wineprefix_xp")
    winearch = "win32"
    emu_exec = paths.join(emu_dir, "flash.exe")

    ## COMPROBAR SI LOS DIRECTORIOS DE GUARDADO ESTÁN CORRECTAMENTE PUESTOS
    os.chdir(emu_dir)
    #utils.iniEditor(paths.join(emuDir, "EMULATOR.INI"), "Dir1", "Z:" + utils.convert2dosPath(paths.dirname(rom)))

    ## CARGAR MODEL2EMU
    #print("env WINEPREFIX=" + wineprefix + " WINEARCH=" + winearch + " wine " + emu_exec + " " + utils.addQuotes("Z:" + utils.convert2dosPath(flash_parse_game(rom))))
    os.system("env WINEPREFIX=" + wineprefix + " WINEARCH=" + winearch + " wine " + emu_exec + " " + utils.addQuotes("Z:" + utils.convert2dosPath(flash_parse_game(rom))))
