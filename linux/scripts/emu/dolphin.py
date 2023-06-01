#!/usr/bin/env python

import os
import os.path as paths
import misc.gamepad_get_info as gcinfo
from misc import _utilities as utils
from configparser import ConfigParser
from pathlib import Path as pathnames


def dolphin_wii_get_id(rom, config):
    name = pathnames(paths.basename(rom)).stem

    config_file = paths.join(config, "gameids.ini")
    inifile = ConfigParser()
    inifile.read(config_file)
    id = inifile.get("Games", name)
    return id

def dolphin_wii_gamepad_config(gameid, config_path, wii_controller, pad_index, pad_guid):
    config = ConfigParser()
    config2 = ConfigParser()
    config.read(config_path)
    config2.read(pad_guid)

    gc_buttons = ["D-Pad/Up", "D-Pad/Down", "D-Pad/Left", "D-Pad/Right",
                  "Buttons/A", "Buttons/B", "Buttons/X", "Buttons/Y",
                  "Buttons/Start",
                  "Triggers/L", "Triggers/L-Analog", "Triggers/R", "Triggers/R-Analog", "Buttons/Z",
                  "Main Stick/Up", "Main Stick/Down", "Main Stick/Left", "Main Stick/Right",
                  "C-Stick/Up", "C-Stick/Down", "C-Stick/Left", "C-Stick/Right",
                  "Rumble/Motor"]

    config.set('GCPad' + str(gc_controller), 'Device', 'SDL/' + "0" + "/" + gcinfo.get_name_from_num(gc_controller))

    for i in gc_buttons:
        pad_btn = config2.get('Profile', i)
        config.set('GCPad' + str(gc_controller), i, pad_btn)

    with open(config_path, 'w') as configfile:
        config.write(configfile)
def dolphin_gc_gamepad_config(config_path, gc_controller, pad_index, pad_guid):
    config = ConfigParser()
    config2 = ConfigParser()
    config.read(config_path)
    config2.read(pad_guid)

    gc_buttons = ["D-Pad/Up", "D-Pad/Down", "D-Pad/Left", "D-Pad/Right",
                   "Buttons/A", "Buttons/B", "Buttons/X", "Buttons/Y",
                   "Buttons/Start",
                   "Triggers/L", "Triggers/L-Analog", "Triggers/R", "Triggers/R-Analog", "Buttons/Z",
                   "Main Stick/Up", "Main Stick/Down", "Main Stick/Left", "Main Stick/Right",
                   "C-Stick/Up", "C-Stick/Down", "C-Stick/Left", "C-Stick/Right",
                   "Rumble/Motor"]

    config.set('GCPad' + str(gc_controller), 'Device', 'SDL/' + "0" + "/" + gcinfo.get_name_from_num(gc_controller))

    for i in gc_buttons:
        pad_btn = config2.get('Profile', i)
        config.set('GCPad' + str(gc_controller), i, pad_btn)

    with open(config_path, 'w') as configfile:
        config.write(configfile)

def dolphin_gc_save_config(config_path, save_dir):
    config = ConfigParser()
    config.read(config_path)
    config.set("Core", "GCIFolderAPath", paths.join(save_dir, "card1"))
    config.set("Core", "GCIFolderBPath", paths.join(save_dir, "card2"))

def load_game(rom, plataforma, active_gamepads):
    retroroot = paths.abspath(paths.join(paths.dirname(__file__), "..", ".."))
    emu_dir = os.path.join(retroroot, "emuladores", "dolphin")
    emu_config_dir = paths.join("/home/manuel/.var/app/org.DolphinEmu.dolphin-emu/config/dolphin-emu/")
    emu_config_file = paths.join(emu_config_dir, "Dolphin.ini")
    emu_config_gc_file = paths.join(emu_config_dir, "GCPadNew.ini")
    emu_config_gc_dir = paths.join(emu_config_dir, "Profiles", "GCPad")
    emu_save_path = paths.abspath(paths.join(retroroot, "saves", plataforma))
    emu_exec = paths.join("/usr/bin/flatpak")
    emu_args = "run --branch=stable --arch=x86_64 --command=/app/bin/dolphin-emu-wrapper org.DolphinEmu.dolphin-emu -b -e " + utils.addQuotes(rom)

    if plataforma == "wii":
        aaa = dolphin_wii_get_id(rom, emu_config_dir)
        print(aaa)

    elif plataforma == "gamecube":
        for i in range(0, len(active_gamepads)):
            gamepad_index = gcinfo.get_gamepad_path_from_guid(active_gamepads[i - 1])
            dolphin_gc_gamepad_config(emu_config_gc_file, i + 1, gamepad_index,
                                      paths.join(emu_config_gc_dir, active_gamepads[i] + ".ini"))

        dolphin_gc_gamepad_config(emu_config_file, emu_save_path)


    os.system(emu_exec + " " + emu_args)
    # utils.replace(emu_config, utils.addQuotes(rom), "directorio1")
