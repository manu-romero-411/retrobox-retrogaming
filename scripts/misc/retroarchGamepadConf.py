#!/usr/bin/env python

import os
import os.path as paths
import xml.etree.ElementTree as xmltree
import sys
import _utilities as utils


def getGamepadIds(gamepadGuid):
    tree = xmltree.parse("/home/manuel/.emulationstation/es_input.cfg")
    root = tree.getroot()
    xmlFind = root.find(".//inputConfig[@deviceGUID='" + gamepadGuid + "']")

    gamepadInfo = [[], [], []]

    for i in range(0, len(xmlFind)):
        gamepadInfo[0].append(xmlFind[i].attrib.get("type"))
        gamepadInfo[1].append(xmlFind[i].attrib.get("id"))
        gamepadInfo[2].append(xmlFind[i].attrib.get("value"))

    return (gamepadInfo)

def getPath(emustationIndex):
    tree = xmltree.parse("/home/manuel/.emulationstation/es_settings.cfg")
    root = tree.getroot()
    for child in root:
        if child.get("name") == "INPUT P" + str(emustationIndex) + "PATH":
            return(child.get("value").split("@")[0][-1])

def getConf():
    tree = xmltree.parse("/home/manuel/.emulationstation/es_settings.cfg")
    root = tree.getroot()

    configs = []
    for child in root:
        for i in range(1, 4):
            if child.get("name") == "INPUT P" + str(i) + "GUID":
                configs.append(getGamepadIds(child.get("value")))
    return (configs)

def getType(configs):
    if configs == "button":
        return("btn")
    elif configs == "axis":
        return("axis")
    else:
        return("btn")

def setButton(configs, iter):
    string = ""
    inputs = configs[0][iter]
    if inputs == "hat":
        string = string + "h"

    string = string + configs[1][iter]
    if inputs == "hat":
        if configs[2][iter] == "4":
            string = string + "down"
        elif configs[2][iter] == "2":
            string = string + "right"
        elif configs[2][iter] == "8":
            string = string + "left"
        elif configs[2][iter] == "1":
            string = string + "up"

    return(string)


def overwrite(file,configs,string,iter):
    rarchInputs = [["axis", "btn", "mbtn"], ["axis", "button", "mbtn"]]
    for i in range(0, len(rarchInputs[0])):
        type = configs[0][iter]
        if type == rarchInputs[1][i] or type == "hat":
            key = ""
            value = ""
            if configs[0][iter] == "axis":
                key = string + "axis"
                axisVal = configs[2][iter]
                if axisVal == "1" or "_plus" in string:
                    value = utils.addQuotes("+" + setButton(configs, iter))
                elif axisVal == "-1" or "_minus" in string:
                    value = utils.addQuotes("-" + setButton(configs, iter))
            else:
                key = string + "btn"
                value = utils.addQuotes(setButton(configs, iter))
        else:
            key = string + rarchInputs[0][i]
            value = "nul"
        utils.iniEditor_spaces(file, key, value)

def setConf(file, configs):
    botones = ["a", "b", "down", "", "l_x_minus", "l_y_plus", "r_x_minus", "r_y_plus", ]
    for i in range(1,len(configs)+1):
        utils.iniEditor_spaces(file, "input_player" + str(i) + "_joypad_index", getPath(i))
        overwrite(file, configs[i-1], "input_player" + str(i) + "_a_", 0)
        overwrite(file, configs[i-1], "input_player" + str(i) + "_b_", 1)
        overwrite(file, configs[i-1], "input_player" + str(i) + "_down_", 2)
        if i == 1:
            overwrite(file, configs[0], "input_enable_hotkey_", 3)
            overwrite(file, configs[0], "input_exit_emulator_", 17)
            overwrite(file, configs[0], "input_menu_toggle_", 1)
            overwrite(file, configs[0], "input_reset_", 0)
            overwrite(file, configs[0], "input_screenshot_", 20)
            overwrite(file, configs[0], "input_disk_eject_toggle_", 13)

        overwrite(file, configs[i-1], "input_player" + str(i) + "_l_x_minus_", 4)
        overwrite(file, configs[i-1], "input_player" + str(i) + "_l_x_plus_", 4)
        overwrite(file, configs[i-1], "input_player" + str(i) + "_l_y_plus_", 5)
        overwrite(file, configs[i-1], "input_player" + str(i) + "_l_y_minus_", 5)
        overwrite(file, configs[i-1], "input_player" + str(i) + "_r_x_minus_", 6)
        overwrite(file, configs[i-1], "input_player" + str(i) + "_r_x_plus_", 6)
        overwrite(file, configs[i-1], "input_player" + str(i) + "_r_y_plus_", 7)
        overwrite(file, configs[i-1], "input_player" + str(i) + "_r_y_minus_", 7)
        overwrite(file, configs[i-1], "input_player" + str(i) + "_l2_", 8)
        overwrite(file, configs[i-1], "input_player" + str(i) + "_l3_", 9)
        overwrite(file, configs[i-1], "input_player" + str(i) + "_left_", 10)
        overwrite(file, configs[i-1], "input_player" + str(i) + "_r_", 11)
        overwrite(file, configs[i-1], "input_player" + str(i) + "_l_", 12)
        overwrite(file, configs[i-1], "input_player" + str(i) + "_r2_", 13)
        overwrite(file, configs[i-1], "input_player" + str(i) + "_r3_", 14)
        overwrite(file, configs[i-1], "input_player" + str(i) + "_right_", 15)
        overwrite(file, configs[i-1], "input_player" + str(i) + "_select_", 16)
        overwrite(file, configs[i-1], "input_player" + str(i) + "_start_", 17)
        overwrite(file, configs[i-1], "input_player" + str(i) + "_up_", 18)
        overwrite(file, configs[i-1], "input_player" + str(i) + "_x_", 19)
        overwrite(file, configs[i-1], "input_player" + str(i) + "_y_", 20)


