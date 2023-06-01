#!/usr/bin/env python

import os
import os.path as paths
import misc.gamepad_get_info as gcinfo
from misc import _utilities as utils
from configparser import ConfigParser



def pcsx2_gamepad_config(config_path, ps2controller, pad_index, pad_guid):
    config = ConfigParser()
    config2 = ConfigParser()
    config.read(config_path)
    config2.read(pad_guid)

    ps2_buttons = ["Up", "Down", "Left", "Right",
                   "Triangle", "Circle", "Cross", "Square",
                   "Select", "Start", "Analog",
                   "L1", "L2", "L3", "R1", "R2", "R3",
                   "LUp", "LDown", "LLeft", "LRight",
                   "RUp", "RDown", "RLeft", "RRight",
                   "LargeMotor", "SmallMotor"]

    config.set('Pad' + str(ps2controller), 'Type', 'DualShock2')

    for i in ps2_buttons:
        pad_btn = config2.get('Pad1', i).split("/")[1]
        config.set('Pad' + str(ps2controller), i, 'SDL-' + pad_index + "/" + pad_btn)

    with open(config_path, 'w') as configfile:
        config.write(configfile)


def load_game(rom, plataforma, active_gamepads):
    retroroot = paths.abspath(paths.join(paths.dirname(__file__), "..", ".."))
    emu_dir = os.path.join(retroroot, "emuladores", "pcsx2")
    emu_config_dir = paths.join("/home/manuel/.config/PCSX2/")
    emu_config_file = paths.join("/home/manuel/.config/PCSX2/inis", "PCSX2.ini")
    emu_save_path = paths.abspath(paths.join(retroroot, "saves", plataforma))
    emu_exec = os.path.join(emu_dir, "pcsx2.AppImage")
    emu_args = "-fullscreen -fastboot " + utils.addQuotes(rom)

    for i in range(0, len(active_gamepads)):
        gamepad_index = gcinfo.get_gamepad_path_from_guid(active_gamepads[i - 1])
        pcsx2_gamepad_config(emu_config_file, i+1, gamepad_index,
                             paths.join(emu_config_dir, "inputprofiles", active_gamepads[i] + ".ini"))

    os.system(emu_exec + " " + emu_args)
    # utils.replace(emu_config, utils.addQuotes(rom), "directorio1")
