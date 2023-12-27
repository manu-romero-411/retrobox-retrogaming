import ctypes,win32con
import os

def getWallpaper():
    ubuf = ctypes.create_unicode_buffer(512)
    ctypes.windll.user32.SystemParametersInfoW(win32con.SPI_GETDESKWALLPAPER,len(ubuf),ubuf,0)
    return ubuf.value

def setWallpaper(path):
    changed = win32con.SPIF_UPDATEINIFILE | win32con.SPIF_SENDCHANGE
    ctypes.windll.user32.SystemParametersInfoW(win32con.SPI_SETDESKWALLPAPER,0,path,changed)

f = open(os.getcwd() + "\.isUserWp", "w", encoding='utf8')
f.write(getWallpaper())
f.close()

setWallpaper(os.getcwd() + "\misc\black.bmp")