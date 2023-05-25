from argparse import ArgumentParser
import sys

def getGamepadsInfo(controllersConfig, idType):
	indexes = []
	guids = []
	names = []
	buttons = []
	hats = []
	axes = []

	for i in range(0,len(controllersConfig)-1):
		if "index" in controllersConfig[i]:
			indexes.append(controllersConfig[i+1])
		elif "guid" in controllersConfig[i]:
			guids.append(controllersConfig[i+1])
		elif "nbbuttons" in controllersConfig[i]:
			buttons.append(controllersConfig[i+1])
		elif "nbhats" in controllersConfig[i]:
			hats.append(controllersConfig[i+1])
		elif "nbaxes" in controllersConfig[i]:
			axes.append(controllersConfig[i+1])
		elif "name" in controllersConfig[i]:
			names.append(controllersConfig[i+1])

	if idType == "indexes":
		return(indexes)
	elif idType == "guids":
		return(guids)
	elif idType == "names":
		return(names)
	elif idType == "buttons":
		return(buttons)
	elif idType == "hats":
		return(hats)
	elif idType == "axes":
		return(axes)
	else:
		return(None)
