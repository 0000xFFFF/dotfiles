#!/usr/bin/env python3

import RPi.GPIO as GPIO
import time
import subprocess
import signal
import os
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


def clearScreen():
    os.system("clear")

def resetCursor():
    print("\033[0;0H", end='')

selected = 0
menu_calls = 0

mutex = Lock()

proc = 0

def doAction():
    global proc
    if selected == 0: return
    elif selected == 1: proc = subprocess.Popen(["airmon-ng"])
    elif selected == 2: proc = subprocess.Popen(["airmon-ng", "start", "wlan1"])
    elif selected == 3: proc = subprocess.Popen(["airmon-ng", "stop", "wlan1"])
    elif selected == 4: proc = subprocess.Popen(["/home/pi/.vip/scripts/hcx-wifi", "wlan1mon"])
    elif selected == 5: proc = subprocess.Popen(["tail", "-f", "/home/pi/Dump/*.log"])
    elif selected == 6: proc = subprocess.Popen(["/home/pi/.vip/scripts/pi_log"])
    elif selected == 7: proc = subprocess.Popen(["/home/pi/.vip/scripts/pi_hcxdumptool_start"])

def killProc():
    global proc
    pid = proc.pid
    os.kill(pid, signal.SIGKILL)

OPT_MIN = 0
OPT_MAX = 7

menu_items = [
    [0, ""],
    [1, "airmon-ng"],
    [2, "airmon-ng start wlan1"],
    [3, "airmon-ng stop wlan1"],
    [4, "hcx-wifi wlan1"],
    [5, "tail -f /home/pi/Dump/*.log"],
    [6, "pi_log"],
    [7, "pi_hcxdumptool_start"]
]

def menu(keyPress):

    mutex.acquire()

    # get stuff
    global selected
    global menu_calls
    global menu_items
    resetCursor()
    clearScreen()
    ts = datetime.now()

    # do logic
    menu_calls += 1
    if   keyPress == 1: selected -= 1
    elif keyPress == 2: selected += 1
    if   selected > OPT_MAX: selected = OPT_MAX
    elif selected < OPT_MIN: selected = OPT_MIN

    # draw
    print("K:",keyPress,menu_calls)
    print(ts)
    print("> ",selected)
    print("")
    print("OPTIONS:")
    for i in menu_items:
        print(f" {'=>' if selected == i[0] else '  '} {i[0]}. {i[1]}")

    if keyPress == 5: doAction()
    if keyPress == 6: killProc()

    mutex.release()


clearScreen()

menu(0)

def callbackMenu(channel):
    if channel == KEY_UP_PIN:    menu(1)
    if channel == KEY_DOWN_PIN:  menu(2)
    if channel == KEY_LEFT_PIN:  menu(3)
    if channel == KEY_RIGHT_PIN: menu(4)
    if channel == KEY_PRESS_PIN: menu(5)
    if channel == KEY1_PIN:      menu(6)
    if channel == KEY2_PIN:      menu(7)
    if channel == KEY3_PIN:      menu(8)


GPIO.setmode(GPIO.BCM)
GPIO.setup(KEY_UP_PIN,    GPIO.IN, pull_up_down=GPIO.PUD_UP)
GPIO.setup(KEY_DOWN_PIN,  GPIO.IN, pull_up_down=GPIO.PUD_UP)
GPIO.setup(KEY_LEFT_PIN,  GPIO.IN, pull_up_down=GPIO.PUD_UP)
GPIO.setup(KEY_RIGHT_PIN, GPIO.IN, pull_up_down=GPIO.PUD_UP)
GPIO.setup(KEY_PRESS_PIN, GPIO.IN, pull_up_down=GPIO.PUD_UP)
GPIO.setup(KEY1_PIN,      GPIO.IN, pull_up_down=GPIO.PUD_UP)
GPIO.setup(KEY2_PIN,      GPIO.IN, pull_up_down=GPIO.PUD_UP)
GPIO.setup(KEY3_PIN,      GPIO.IN, pull_up_down=GPIO.PUD_UP)

GPIO.add_event_detect(KEY_UP_PIN,    GPIO.RISING, callback=callbackMenu)
GPIO.add_event_detect(KEY_DOWN_PIN,  GPIO.RISING, callback=callbackMenu)
GPIO.add_event_detect(KEY_LEFT_PIN,  GPIO.RISING, callback=callbackMenu)
GPIO.add_event_detect(KEY_RIGHT_PIN, GPIO.RISING, callback=callbackMenu)
GPIO.add_event_detect(KEY_PRESS_PIN, GPIO.RISING, callback=callbackMenu)
GPIO.add_event_detect(KEY1_PIN,      GPIO.RISING, callback=callbackMenu)
GPIO.add_event_detect(KEY2_PIN,      GPIO.RISING, callback=callbackMenu)
GPIO.add_event_detect(KEY3_PIN,      GPIO.RISING, callback=callbackMenu)

input()
