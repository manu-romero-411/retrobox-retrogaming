#!/usr/bin/env python

import fileinput
import os
import os.path as paths
import sys
import subprocess
import shutil

def antimicro_load_profile(profile):
	return subprocess.Popen([shutil.which("antimicrox"),"--hidden","--profile", profile], shell=True)
	#os.spawnl(os.P_DETACH, shutil.which("antimicrox") + " --hidden --profile " + profile)
def antimicro_close():
	os.system("killall antimicrox")

## https://stackoverflow.com/questions/17140886/how-to-search-and-replace-text-in-a-file
def replace(file, orig, new):
	print(file)
	# Read in the file
	with open(file, 'r') as file_read:
		filedata = file_read.read()

	# Replace the target string
	filedata = filedata.replace(orig, new)

	# Write the file out again
	with open(file, 'w') as file_write:
		file_write.write(filedata)
def addQuotes(str):
	strq = f'"{str}"'
	return strq

def iniEditor_spaces(path, key, value):
	for line in fileinput.input([path], inplace=True):
		if line.strip().startswith(key + " = "):
			line = key + " = " + str(value) + "\n"
		sys.stdout.write(line)

def getIniProp_spaces(path, key):
	file = open(path, "r")
	for line in file:
		if line.startswith(key + " = "):
			return(line.split(" = ")[1])

def iniEditor(path, key, value):
	for line in fileinput.input([path], inplace=True):
		if line.strip().startswith(key + "="):
			line = key + "=" + str(value) + "\n"
		sys.stdout.write(line)

def convert2dosPath(unixPath):
	return unixPath.replace('/', '\\')

def filename(unixPath):
	return paths.basename(paths.splitext(unixPath)[0])
