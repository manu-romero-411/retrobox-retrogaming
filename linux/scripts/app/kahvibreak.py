#!/usr/bin/env python

import os
import os.path as paths
import misc._utilities as utils

def load():

    retroroot = paths.abspath(paths.join(paths.dirname(__file__), "..", ".."))
    app_path = paths.join(retroroot, "kahvibreak")
    app_exec = paths.join(app_path, "start.sh")
    app_args = ""
    #utils.antimicro_load_profile(paths.join(retroroot, "antimicro", "webapp.gamecontroller.amgp"))

    os.chdir(app_path)
    os.system(app_exec + " " + app_args)

if __name__ == '__main__':
    load()
    exit(0)