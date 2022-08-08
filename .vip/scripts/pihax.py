#!/usr/bin/env python3

# TODO: kill process menu
#       rename and sort vars
#       print stuff with show()

import RPi.GPIO as GPIO
import time
import subprocess
import signal
import os
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


def clearScreen():
	os.system("clear")
def resetCursor():
    print("\033[0;0H", end='')
def hideCursor():
	print("\033[?25l")
def showCursor():
	print("\033[?25h")
def is_root():
    return os.geteuid() == 0

def runcmd_getLines(cmd):
    output = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    return output.stdout.read().decode().split("\n")

fetch_processes = [ "hcx", "pi_log", "pi_dump", "tail" ]
def getProcesses():
    for i in fetch_processes:
        runcmd_getLines(i)


menu_opt = 0
menu_calls = 0
menu_mutex = Lock()
runprog_mutex = Lock()
proc = 0

def runprog_thread(lst):
    runprog_mutex.acquire()
    global proc
    proc = subprocess.Popen(lst)
    runprog_mutex.release()
    print(f"started PID: {proc.pid}")
    os.waitpid(proc.pid, 0)
    print(f"died: {proc.pid}")

def runprog(lst):
    t = Thread(target = runprog_thread, args = (lst,))
    t.start()

def doAction():
    if   menu_opt ==  0: return
    elif menu_opt ==  1: runprog(["airmon-ng"])
    elif menu_opt ==  2: runprog(["airmon-ng", "start", "wlan1"])
    elif menu_opt ==  3: runprog(["airmon-ng", "stop", "wlan1"])
    elif menu_opt ==  4: runprog(["/home/pi/.vip/scripts/hcx-wifi-rpi", "wlan1mon", "/home/pi/Hashes/cracked.csv"]) # TODO: stop getting input while this script is running
    elif menu_opt ==  5: runprog(["/home/pi/.vip/scripts/pi_dump"])
    elif menu_opt ==  6: runprog(["/home/pi/.vip/scripts/pi_log"])
    elif menu_opt ==  7: runprog(["/home/pi/.vip/scripts/pi_log1"])
    elif menu_opt ==  8: runprog(["/home/pi/.vip/scripts/pi_hcxdumptool_start"])
    elif menu_opt ==  9: runprog(["/home/pi/.vip/scripts/pi_hcxdumptool_start_quiet"])
    elif menu_opt == 10: runprog(["/home/pi/.vip/scripts/pi_running"])
    elif menu_opt == 11: runprog(["/home/pi/.vip/scripts/pi_running_kill"])
    elif menu_opt == 12: runprog(["/home/pi/.vip/scripts/wlan-dump"])

def killProc():
    global proc
    print(f"KILL: {proc.pid}")
    try:
        os.kill(proc.pid, signal.SIGTERM)
    except ProcessLookupError:
        print("ProcessLookupError")

menu_items = [
    [ 0, ""],
    [ 1, "airmon-ng"],
    [ 2, "airmon-ng start wlan1"],
    [ 3, "airmon-ng stop wlan1"],
    [ 4, "hcx-wifi-rpi wlan1mon"],
    [ 5, "pi_dump"],
    [ 6, "pi_log"],
    [ 7, "pi_log1"],
    [ 8, "pi_hcxdumptool_start"],
    [ 9, "pi_hcxdumptool_start_quiet"],
    [10, "pi_running"],
    [11, "pi_running_kill"],
    [12, "wlan-dump"]
]

OPT_MIN = 0
OPT_MAX = len(menu_items) - 1

def menu(keyPress):

    menu_mutex.acquire()

    global menu_opt
    global menu_calls
    global menu_items
    resetCursor()
    if keyPress == 3: clearScreen()

    menu_calls += 1
    if   keyPress == 1: menu_opt -= 1
    elif keyPress == 2: menu_opt += 1
    if   menu_opt > OPT_MAX: menu_opt = OPT_MAX
    elif menu_opt < OPT_MIN: menu_opt = OPT_MIN

    # draw
    print(f"[{keyPress}] | {menu_opt} - {OPT_MIN}/{OPT_MAX} | {menu_calls}")
    print(datetime.now())
    print("")
    for i in menu_items:
        num = str(i[0]).rjust(3, " ")
        cmd = i[1]
        if menu_opt == i[0]:
            print(f"{Style.NORMAL}{Fore.GREEN} => {num}. {cmd} {Style.RESET_ALL}")
        else:
            print(f"    {num}. {cmd}")

    if keyPress == 5: doAction()
    if keyPress == 6: killProc()
    if keyPress == 4: clearScreen()

    menu_mutex.release()

def menu_callback(channel):
    time.sleep(0.1)
    if GPIO.input(channel) == 1:
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

GPIO.add_event_detect(KEY_UP_PIN,    GPIO.BOTH, callback=menu_callback, bouncetime=100)
GPIO.add_event_detect(KEY_DOWN_PIN,  GPIO.BOTH, callback=menu_callback, bouncetime=100)
GPIO.add_event_detect(KEY_LEFT_PIN,  GPIO.BOTH, callback=menu_callback, bouncetime=100)
GPIO.add_event_detect(KEY_RIGHT_PIN, GPIO.BOTH, callback=menu_callback, bouncetime=100)
GPIO.add_event_detect(KEY_PRESS_PIN, GPIO.BOTH, callback=menu_callback, bouncetime=100)
GPIO.add_event_detect(KEY1_PIN,      GPIO.BOTH, callback=menu_callback, bouncetime=100)
GPIO.add_event_detect(KEY2_PIN,      GPIO.BOTH, callback=menu_callback, bouncetime=100)
GPIO.add_event_detect(KEY3_PIN,      GPIO.BOTH, callback=menu_callback, bouncetime=100)

clearScreen()
menu(0)

#input()
while True:
    time.sleep(5)
