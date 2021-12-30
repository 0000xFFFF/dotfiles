#!/usr/bin/env python

import os
import sys
import time
import subprocess
import signal
import atexit
import RPi.GPIO as GPIO
from colorama import Fore, Back, Style
from threading import Thread, Lock
from datetime import datetime

RST_PIN       = 25
CS_PIN        = 8
DC_PIN        = 24
RST           = 27
DC            = 25
BL            = 24
bus           = 0
device        = 0
KEY_UP_PIN    = 6
KEY_DOWN_PIN  = 19
KEY_LEFT_PIN  = 5
KEY_RIGHT_PIN = 26
KEY_PRESS_PIN = 13
KEY1_PIN      = 21
KEY2_PIN      = 20
KEY3_PIN      = 16

def gpio_setup():
    GPIO.setmode(GPIO.BCM)
    GPIO.setup(KEY_UP_PIN,    GPIO.IN, pull_up_down=GPIO.PUD_UP)
    GPIO.setup(KEY_DOWN_PIN,  GPIO.IN, pull_up_down=GPIO.PUD_UP)
    GPIO.setup(KEY_LEFT_PIN,  GPIO.IN, pull_up_down=GPIO.PUD_UP)
    GPIO.setup(KEY_RIGHT_PIN, GPIO.IN, pull_up_down=GPIO.PUD_UP)
    GPIO.setup(KEY_PRESS_PIN, GPIO.IN, pull_up_down=GPIO.PUD_UP)
    GPIO.setup(KEY1_PIN,      GPIO.IN, pull_up_down=GPIO.PUD_UP)
    GPIO.setup(KEY2_PIN,      GPIO.IN, pull_up_down=GPIO.PUD_UP)
    GPIO.setup(KEY3_PIN,      GPIO.IN, pull_up_down=GPIO.PUD_UP)

# glbl stuff
running = True
running_menu = False
menu_opt = 1
proc = 0
path_device = "/tmp/wlan-rpi_device"
selected_device = ""

menu_items = [
    [ 1, "ping google"],
    [ 2, "wlan-rpi"],
    [ 3, "wlan load"],
    [ 4, "hcx-wifi-rpi pass"],
    [ 5, "hcx-wifi-rpi hashed"],
    [ 6, "hcx-logs-rpi"],
    [ 7, "dumptool"],
    [ 8, "dumptool quiet"],
    [ 9, "show running"],
    [10, "kill all"],
    [11, "scan wifis"],
    [12, "reboot"],
    [13, "poweroff"],
]

OPT_MIN = 1
OPT_MAX = len(menu_items)

def checkRoot(): return os.geteuid() == 0

term_show_count = 0
g_tc = os.get_terminal_size().columns
g_tl = os.get_terminal_size().lines
def term_show_count_reset():
    global term_show_count
    term_show_count = 0
def term_clear():
    os.system("clear")
    term_show_count_reset()
def term_cursor_reset():
    print("\033[0;0H", end='')
    term_show_count_reset()
def term_cursor_hide():
    print("\033[?25l")
def term_cursor_show():
    print("\033[?25h")
def term_blank():
    term_cursor_hide()
    term_clear()
def term_show_print(printStr, color = ""):
    global term_show_count
    tl = os.get_terminal_size().lines
    if term_show_count >= (tl-1): return
    print(f"{color}{printStr}{Style.RESET_ALL}")
    term_show_count += 1
def term_show(s, color = ""):
    global g_tc
    global g_tl
    strings = s.split("\n")
    tc = os.get_terminal_size().columns
    tl = os.get_terminal_size().lines
    if g_tc != tc or g_tl != tl:
        g_tc = tc
        g_tl = tl
        term_clear()
    for i in strings:
        il = len(i)
        if il > tc: term_show_print(i[:tc], color)
        else:       term_show_print(i + str(" " * int(int(tc)-int(il))), color)

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

def action_opt_up():
    global menu_opt
    global OPT_MIN
    menu_opt -= 1
    if menu_opt < OPT_MIN: menu_opt = OPT_MIN
def action_opt_down():
    global menu_opt
    global OPT_MAX
    menu_opt += 1
    if menu_opt > OPT_MAX: menu_opt = OPT_MAX
def action_quit():
    global running
    print("\n\nQuitting...")
    running = False

def action_load():
    global selected_device
    global path_device
    try:
        with open(path_device) as f:
            selected_device = f.readline().rstrip()
    except:
        pass
    
    term_blank()
    print(f"loaded: {selected_device}")

def action_run():
    global menu_opt
    if   menu_opt ==  1: runproga(["ping", "8.8.8.8"])
    elif menu_opt ==  2: runprog(["/home/pi/.vip/scripts/wlan-rpi"])
    elif menu_opt ==  3: action_load()
    elif menu_opt ==  4: runprog(["/home/pi/.vip/scripts/hcx-wifi-rpi", selected_device, "/home/pi/Hashes/passlst.csv"])
    elif menu_opt ==  5: runprog(["/home/pi/.vip/scripts/hcx-wifi-rpi", selected_device, "/home/pi/Hashes/hashedlst.csv"])
    elif menu_opt ==  6: runprog(["/home/pi/.vip/scripts/hcx-logs-rpi", "/home/pi/Dump"])
    elif menu_opt ==  7: runproga(["/home/pi/.vip/scripts/pi_hcxdumptool_start", selected_device])
    elif menu_opt ==  8: runproga(["/home/pi/.vip/scripts/pi_hcxdumptool_start_quiet", selected_device])
    elif menu_opt ==  9: runprog(["/home/pi/.vip/scripts/pi_running"])
    elif menu_opt == 10: runprog(["/home/pi/.vip/scripts/pi_running_kill"])
    elif menu_opt == 11: runprog(["/home/pi/.vip/scripts/wlan-dump"])
    elif menu_opt == 12:
        runprog(["shutdown", "-r", "now"])
        action_quit()
    elif menu_opt == 13:
        runprog(["shutdown", "-P", "now"])
        action_quit()

def action_kill():
    global proc
    try:
        print(f"KILL: {proc.pid}")
        os.kill(proc.pid, signal.SIGTERM)
    except ProcessLookupError: print("ProcessLookupError")
    except: print("process not found")

def menu(keyPress):

    global running_menu
    if running_menu: return
    running_menu = True

    term_cursor_reset()

    global menu_opt
    global menu_items
    global selected_device

    if   keyPress == 1: action_opt_up()
    elif keyPress == 2: action_opt_down()
    elif keyPress == 3: term_blank()

    # draw
    term_show(f"{str(datetime.now())}"       , f"{Style.BRIGHT}{Fore.GREEN}")
    term_show(f"device -> {selected_device}" , f"{Style.BRIGHT}{Fore.RED}")

    for i in menu_items:
        num = str(i[0]).rjust(3, " ")
        cmd = i[1]
        if menu_opt == i[0]: term_show(f">{num}. {cmd}" , f"{Style.NORMAL}{Back.WHITE}{Fore.BLACK}")
        else:                term_show(f" {num}. {cmd}")

    if   keyPress == 4: term_blank()
    elif keyPress == 5: action_run()
    elif keyPress == 6: action_kill()
    elif keyPress == 8: action_quit()

    running_menu = False

if __name__ == "__main__":

    if not checkRoot():
        print("use root.")
        exit()

    gpio_setup()

    term_blank()
    action_load()
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
    except KeyboardInterrupt:
        action_quit()
    except Exception as e:
        if hasattr(e, 'message'): print(e.message)
        else: print(e)
        action_quit()

