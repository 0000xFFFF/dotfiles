#!/usr/bin/env python3

import os
import sys
import time
import subprocess
import signal
import atexit
#import getchlib
import RPi.GPIO as GPIO
from colorama import Fore, Back, Style
from threading import Thread, Lock
from datetime import datetime

RST_PIN = 25
CS_PIN  = 8
DC_PIN  = 24

RST    = 27
DC     = 25
BL     = 24
bus    = 0
device = 0

# LCD keys
KEY_UP_PIN    = 6
KEY_DOWN_PIN  = 19
KEY_LEFT_PIN  = 5
KEY_RIGHT_PIN = 26
KEY_PRESS_PIN = 13
KEY1_PIN      = 21
KEY2_PIN      = 20
KEY3_PIN      = 16

# glbl stuff
running = True
running_menu = False
menu_opt = 0
menu_calls = 0
proc = 0

def checkRoot():
    return os.geteuid() == 0
def term_clear():
    os.system("clear")
def term_cursor_reset():
    print("\033[0;0H", end='')
def term_cursor_hide():
    print("\033[?25l")
def term_cursor_show():
    print("\033[?25h")
def term_blank():
    term_cursor_hide()
    term_clear()


@atexit.register
def signal_handler():
    term_cursor_show()

def runprog(lst):
    global proc
    proc = subprocess.Popen(lst)
    print(f"started PID: {proc.pid}")
    os.waitpid(proc.pid, 0)
    print(f"died: {proc.pid}")
def runproga(lst):
    t = Thread(target = runprog, args = (lst,))
    t.start()

menu_items = [
    [ 0, ""],
    [ 1, "airmon-ng"],
    [ 2, "airmon-ng start wlan1"],
    [ 3, "airmon-ng stop wlan1mon"],
    [ 4, "hcx-wifi-rpi wlan1mon"],
    [ 5, "pi_dump"],
    [ 6, "pi_log"],
    [ 7, "pi_log1"],
    [ 8, "pi_hcxdumptool_start"],
    [ 9, "pi_hcxdumptool_start_quiet"],
    [10, "pi_running"],
    [11, "pi_running_kill"],
    [12, "wlan-dump"],
    [13, "exa /home/pi/Dump"],
    [14, "exa -lah /home/pi/Dump"],
]

OPT_MIN = 0
OPT_MAX = len(menu_items) - 1

def action_opt_cap():
    global menu_opt
    global OPT_MIN
    global OPT_MAX
    if   menu_opt > OPT_MAX: menu_opt = OPT_MAX
    elif menu_opt < OPT_MIN: menu_opt = OPT_MIN
def action_opt_up():
    global menu_opt
    menu_opt -= 1
    action_opt_cap()
def action_opt_down():
    global menu_opt
    menu_opt += 1
    action_opt_cap()
def action_quit():
    global running
    print("Quitting...")
    running = False

def action_run():
    global menu_opt
    if   menu_opt ==  0: return
    elif menu_opt ==  1: runprog(["airmon-ng"])
    elif menu_opt ==  2: runprog(["airmon-ng", "start", "wlan1"])
    elif menu_opt ==  3: runprog(["airmon-ng", "stop", "wlan1mon"])
    elif menu_opt ==  4: runprog(["python", "/home/pi/.vip/scripts/hcx-wifi-rpi", "wlan1mon", "/home/pi/Hashes/cracked.csv"])
    elif menu_opt ==  5: runproga(["/home/pi/.vip/scripts/pi_dump"])
    elif menu_opt ==  6: runproga(["/home/pi/.vip/scripts/pi_log"])
    elif menu_opt ==  7: runprog(["/home/pi/.vip/scripts/pi_log1"])
    elif menu_opt ==  8: runproga(["/home/pi/.vip/scripts/pi_hcxdumptool_start"])
    elif menu_opt ==  9: runproga(["/home/pi/.vip/scripts/pi_hcxdumptool_start_quiet"])
    elif menu_opt == 10: runprog(["/home/pi/.vip/scripts/pi_running"])
    elif menu_opt == 11: runprog(["/home/pi/.vip/scripts/pi_running_kill"])
    elif menu_opt == 12: runprog(["/home/pi/.vip/scripts/wlan-dump"])
    elif menu_opt == 13: runprog(["exa", "/home/pi/Dump"])
    elif menu_opt == 14: runprog(["exa", "-lah", "/home/pi/Dump"])

def action_kill():
    global proc
    try:
        print(f"KILL: {proc.pid}")
        os.kill(proc.pid, signal.SIGTERM)
    except ProcessLookupError:
        print("ProcessLookupError")
    except:
        print("process not found")

def menu(keyPress):

    global running_menu
    if running_menu: return

    running_menu = True

    global menu_opt
    global menu_calls
    global menu_items
    term_cursor_reset()

    menu_calls += 1
    if   keyPress == 1: action_opt_up()
    elif keyPress == 2: action_opt_down()
    elif keyPress == 3: term_blank()

    # draw
    print(f"{Style.BRIGHT}{Fore.RED}[{keyPress}]{Style.RESET_ALL} | {Style.BRIGHT}{Fore.YELLOW}{menu_opt} <- {OPT_MIN}-{OPT_MAX}{Style.RESET_ALL} | {Style.BRIGHT}{Fore.CYAN}{menu_calls}{Style.RESET_ALL}")
    print(f"{Style.BRIGHT}{Fore.GREEN}{str(datetime.now())}{Style.RESET_ALL}")
    print("")
    for i in menu_items:
        num = str(i[0]).rjust(3, " ")
        cmd = i[1]
        if menu_opt == i[0]:
            print(f"{Style.NORMAL}{Back.WHITE}{Fore.BLACK} => {num}. {cmd}{Style.RESET_ALL}")
        else:
            print(f"    {num}. {cmd}")

    if   keyPress == 4: term_blank()
    elif keyPress == 5: action_run()
    elif keyPress == 6: action_kill()
    elif keyPress == 8: action_quit()

    running_menu = False

#menu_callback_block = False
#def menu_callback(channel):
#    global menu_callback_block
#    if menu_callback_block: return
#
#    if GPIO.input(channel) == 1:
#        menu_callback_block = True
#        if   channel == KEY_UP_PIN:    menu(1)
#        elif channel == KEY_DOWN_PIN:  menu(2)
#        elif channel == KEY_LEFT_PIN:  menu(3)
#        elif channel == KEY_RIGHT_PIN: menu(4)
#        elif channel == KEY_PRESS_PIN: menu(5)
#        elif channel == KEY1_PIN:      menu(6)
#        elif channel == KEY2_PIN:      menu(7)
#        elif channel == KEY3_PIN:      menu(8)
#        menu_callback_block = False

def gpio_setup():
    btime = 200
    GPIO.setmode(GPIO.BCM)
    GPIO.setup(KEY_UP_PIN,    GPIO.IN, pull_up_down=GPIO.PUD_UP)
    GPIO.setup(KEY_DOWN_PIN,  GPIO.IN, pull_up_down=GPIO.PUD_UP)
    GPIO.setup(KEY_LEFT_PIN,  GPIO.IN, pull_up_down=GPIO.PUD_UP)
    GPIO.setup(KEY_RIGHT_PIN, GPIO.IN, pull_up_down=GPIO.PUD_UP)
    GPIO.setup(KEY_PRESS_PIN, GPIO.IN, pull_up_down=GPIO.PUD_UP)
    GPIO.setup(KEY1_PIN,      GPIO.IN, pull_up_down=GPIO.PUD_UP)
    GPIO.setup(KEY2_PIN,      GPIO.IN, pull_up_down=GPIO.PUD_UP)
    GPIO.setup(KEY3_PIN,      GPIO.IN, pull_up_down=GPIO.PUD_UP)
    #GPIO.add_event_detect(KEY_UP_PIN,    GPIO.RISING, callback=menu_callback, bouncetime=btime)
    #GPIO.add_event_detect(KEY_DOWN_PIN,  GPIO.RISING, callback=menu_callback, bouncetime=btime)
    #GPIO.add_event_detect(KEY_LEFT_PIN,  GPIO.RISING, callback=menu_callback, bouncetime=btime)
    #GPIO.add_event_detect(KEY_RIGHT_PIN, GPIO.RISING, callback=menu_callback, bouncetime=btime)
    #GPIO.add_event_detect(KEY_PRESS_PIN, GPIO.RISING, callback=menu_callback, bouncetime=btime)
    #GPIO.add_event_detect(KEY1_PIN,      GPIO.RISING, callback=menu_callback, bouncetime=btime)
    #GPIO.add_event_detect(KEY2_PIN,      GPIO.RISING, callback=menu_callback, bouncetime=btime)
    #GPIO.add_event_detect(KEY3_PIN,      GPIO.RISING, callback=menu_callback, bouncetime=btime)

if __name__ == "__main__":

    if not checkRoot():
        print("use root.")
        exit()

    gpio_setup()

    term_blank()
    menu(0)


    try:
        while running:
            if   not GPIO.input(KEY_UP_PIN):    menu(1)
            elif not GPIO.input(KEY_DOWN_PIN):  menu(2)
            elif not GPIO.input(KEY_LEFT_PIN):  menu(3)
            elif not GPIO.input(KEY_RIGHT_PIN): menu(4)
            elif not GPIO.input(KEY_PRESS_PIN): menu(5)
            elif not GPIO.input(KEY1_PIN):      menu(6)
            elif not GPIO.input(KEY2_PIN):      menu(7)
            elif not GPIO.input(KEY3_PIN):      menu(8)
            time.sleep(0.2)
    except:
        print("\n")
        action_quit()

    #while running:
    #    try:
    #        pressedKey = getchlib.getkey()
    #        if   pressedKey == "w": menu(1)
    #        elif pressedKey == "s": menu(2)
    #        elif pressedKey == "a": menu(3)
    #        elif pressedKey == "d": menu(4)
    #        elif pressedKey == "q": action_quit()
    #        elif pressedKey == "e": menu(5)
    #        elif pressedKey == "r": menu(6)
    #        elif pressedKey == "f": menu(7)
    #        elif pressedKey == "v": menu(8)
    #        elif pressedKey == '\x1b[A': menu(1)
    #        elif pressedKey == '\x1b[B': menu(2)
    #        elif pressedKey == '\x1b[D': menu(3)
    #        elif pressedKey == '\x1b[C': menu(4)
    #    except KeyboardInterrupt:
    #        action_quit()



