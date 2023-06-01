#!/usr/bin/env python

import os

def load():
    app_exec = "/usr/local/bin/vfio-iniciarVM"
    app_args = "android"

    os.system(app_exec + " " + app_args)

if __name__ == '__main__':
    load()
    exit(0)