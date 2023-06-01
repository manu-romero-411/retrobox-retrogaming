#!/usr/bin/env python

import os

def load():
    app_exec = "/usr/bin/flatpak"
    app_args = "run --branch=stable --arch=x86_64 --command=kodi tv.kodi.Kodi"

    os.system(app_exec + " " + app_args)

if __name__ == '__main__':
    load()
    exit(0)