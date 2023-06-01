#!/usr/bin/env python
import importlib
import os
import os.path as paths
import shutil

from misc import _utilities as utils


def web_parse(path):
    with open(path, "r") as infile:
        return infile.readline().split("=")[1].split("\n")[0]

def load(rom, app):
    retroroot = paths.abspath(paths.join(paths.dirname(__file__), "..", ".."))
    app_exec = " "
    app_args = " "
    app_name = web_parse(rom)
    proc = ""
    if "http" in app_name:
        proc = utils.antimicro_load_profile(paths.join(retroroot, "antimicro", "webapp.gamecontroller.amgp"))
        app_script = importlib.import_module("app.web." + app)
        app_script.load(app_name)
    else:
        app_script = importlib.import_module("app." + app_name)
        app_script.load(app_name)


    #utils.replace(emu_config, "directorio1", utils.addQuotes(rom))
    os.system(app_exec + " " + app_args)
    #utils.replace(emu_config, utils.addQuotes(rom), "directorio1")
    proc.terminate()
