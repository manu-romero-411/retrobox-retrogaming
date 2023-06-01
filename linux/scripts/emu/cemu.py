#!/usr/bin/env python

import os
import os.path as paths
from misc import _utilities as utils
import misc.gamepad_get_info as gpinfo


def cemu_config_gamepads(path, guid, index):
    os.system("cp " + paths.join(path, str(guid) + ".xml" + " "
                                 + paths.join(path, "controller" + str(index) + ".xml")))


def cemu_parse_game(dir):
    with open(dir + "/cemu.cfg", "r") as infile:
        return dir + "/code/" + infile.readline().split("=")[1].split(".rpx")[0] + ".rpx"


def load_game(rom, plataforma, active_gamepads):
    retroroot = paths.abspath(paths.join(paths.dirname(__file__), "..", ".."))
    emuDir = os.path.join(retroroot, "emuladores", "cemu")
    savePath = paths.abspath(paths.join(retroroot, "saves", plataforma))
    emu_conf_gamepad = "/home/manuel/.config/Cemu/controllerProfiles"

    for i in range(0, len(active_gamepads)):
        cemu_config_gamepads(emu_conf_gamepad, active_gamepads[i], i)

    os.system(paths.join(emuDir, "Cemu") + " --fullscreen --game " + utils.addQuotes(cemu_parse_game(rom)))
