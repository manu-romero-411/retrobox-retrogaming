#!/usr/bin/env python

import os
import os.path as paths
from misc import _utilities as utils

def load(web):
    retroroot = paths.abspath(paths.join(paths.dirname(__file__), "../..", ".."))
    emu_exec = "google-chrome-stable"
    emu_args = "--force-device-scale-factor=1.25 --kiosk --profile-directory=\"Retrobox\" " + utils.addQuotes(web)

    os.system(emu_exec + " " + emu_args)
