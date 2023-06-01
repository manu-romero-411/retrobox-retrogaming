#!/usr/bin/env python

import xml.etree.ElementTree as xmltree
from misc import _utilities as utils


def get_gamepad_mappings(guid):
    tree = xmltree.parse("/home/manuel/.emulationstation/es_input.cfg")
    root = tree.getroot()
    xmlFind = root.find(".//inputConfig[@deviceGUID='" + guid + "']")

    gamepadInfo = [[], [], []]

    for i in range(0, len(xmlFind)):
        gamepadInfo[0].append(xmlFind[i].attrib.get("type"))
        gamepadInfo[1].append(xmlFind[i].attrib.get("id"))
        gamepadInfo[2].append(xmlFind[i].attrib.get("value"))

    return (gamepadInfo)

def get_gamepad_path_from_guid(guid):
    tree = xmltree.parse("/home/manuel/.emulationstation/es_settings.cfg")
    root = tree.getroot()
    for child in root:
        name = child.get("name")
        value = child.get("value")
        if "PATH" in name and guid in value:
            return(value.split("@")[0][-1])

def get_name_from_num(num):
    tree = xmltree.parse("/home/manuel/.emulationstation/es_settings.cfg")
    root = tree.getroot()
    for child in root:
        name = child.get("name")
        value = child.get("value")
        if "P" + str(num) + "NAME" in name:
            return value


def get_gamepad_path(emustationIndex):
    tree = xmltree.parse("/home/manuel/.emulationstation/es_settings.cfg")
    root = tree.getroot()
    for child in root:
        if child.get("name") == "INPUT P" + str(emustationIndex) + "PATH":
            return(child.get("value").split("@")[0][-1])

def get_gamepad_guid(index):
    tree = xmltree.parse("/home/manuel/.emulationstation/es_settings.cfg")
    root = tree.getroot()

    for child in root:
        if child.get("name") == "INPUT P" + str(index) + "GUID":
            return (child.get("value"))

    return (-1)