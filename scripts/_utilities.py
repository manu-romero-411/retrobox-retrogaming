#!/usr/bin/env python

import fileinput
import os.path as paths
import sys
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
