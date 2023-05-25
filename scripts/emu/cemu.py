#!/usr/bin/env python

import os
import os.path as paths
import sys
import _utilities as utils

def cemu_parseGame(dir):
	with open(dir + "/cemu.cfg", "r") as infile:
		return dir + "/code/" + infile.readline().split("=")[1].split(".rpx")[0] + ".rpx"

def loadGame(rom, plataforma):
	retroroot = paths.abspath(paths.join(paths.dirname(__file__), "..", ".."))
	emuDir = os.path.join(retroroot, "emuladores", "cemu")
	savePath = paths.abspath(paths.join(retroroot, "saves", plataforma))

	os.system(paths.join(emuDir,"Cemu") + " --fullscreen --game " + utils.addQuotes(cemu_parseGame(rom)))


