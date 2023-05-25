#!/usr/bin/env python
import _utilities as utils

toggle_values = ["\"true\"", "\"false\""]
def toggleCheck(toggle):
    if toggle != 1 and toggle != 0:
        raise Exception("Toggle incorrecto")

def toggleQuickExit(file):
    if utils.getIniProp_spaces(file, "quit_press_twice") == toggle_values[0]:
        utils.iniEditor_spaces(file, "quit_press_twice", toggle_values[1])
    else:
        utils.iniEditor_spaces(file, "quit_press_twice", toggle_values[1])

def setQuickExit(file, toggle):
    toggleCheck(toggle)
    utils.iniEditor_spaces(file, "quit_press_twice", toggle_values[toggle])

def setVideoDriver(file, driver):
    utils.iniEditor_spaces(file, "video_driver", driver)

def setDiscord(file, toggle):
    utils.iniEditor_spaces(file, "discord_allow", toggle_values[toggle])

# TODO LO SIGUIENTE HAY QUE IMPLEMENTARLO POR SI ES POSIBLE AJUSTARLO DESDE EL MENÚ
#notification_show_autoconfig = "true"
#notification_show_cheats_applied = "true"
#notification_show_config_override_load = "true"
#notification_show_fast_forward = "true"
#notification_show_netplay_extra = "false"
#notification_show_patch_applied = "true"
#notification_show_refresh_rate = "true"
#notification_show_remap_load = "true"
#notification_show_screenshot = "true"
#notification_show_screenshot_duration = "0"
#notification_show_screenshot_flash = "0"
#notification_show_set_initial_disk = "true"
#notification_show_when_menu_is_alive = "false"
#menu_show_load_content_animation = "true"
#video_smooth = "true"