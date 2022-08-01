import spidev as SPI
import RPi.GPIO as GPIO

import time
import subprocess

#GPIO define
RST_PIN        = 25
CS_PIN         = 8
DC_PIN         = 24

KEY_UP_PIN     = 6 
KEY_DOWN_PIN   = 19
KEY_LEFT_PIN   = 5
KEY_RIGHT_PIN  = 26
KEY_PRESS_PIN  = 13

KEY1_PIN       = 21
KEY2_PIN       = 20
KEY3_PIN       = 16

RST = 27
DC = 25
BL = 24
bus = 0 
device = 0 

GPIO.setmode(GPIO.BCM) 
GPIO.setup(KEY_UP_PIN,      GPIO.IN, pull_up_down=GPIO.PUD_UP) # Input with pull-up
GPIO.setup(KEY_DOWN_PIN,    GPIO.IN, pull_up_down=GPIO.PUD_UP) # Input with pull-up
GPIO.setup(KEY_LEFT_PIN,    GPIO.IN, pull_up_down=GPIO.PUD_UP) # Input with pull-up
GPIO.setup(KEY_RIGHT_PIN,   GPIO.IN, pull_up_down=GPIO.PUD_UP) # Input with pull-up
GPIO.setup(KEY_PRESS_PIN,   GPIO.IN, pull_up_down=GPIO.PUD_UP) # Input with pull-up
GPIO.setup(KEY1_PIN,        GPIO.IN, pull_up_down=GPIO.PUD_UP) # Input with pull-up
GPIO.setup(KEY2_PIN,        GPIO.IN, pull_up_down=GPIO.PUD_UP) # Input with pull-up
GPIO.setup(KEY3_PIN,        GPIO.IN, pull_up_down=GPIO.PUD_UP) # Input with pull-up

while 1:
    # with canvas(device) as draw:
    if GPIO.input(KEY_UP_PIN): pass
    else: print("UP")
    if GPIO.input(KEY_LEFT_PIN): pass
    else: print("LEFT")
    if GPIO.input(KEY_RIGHT_PIN): pass
    else: print("RIGHT")
    if GPIO.input(KEY_DOWN_PIN): pass
    else: print("DOWN")
    if GPIO.input(KEY_PRESS_PIN): pass
    else: print("PRESS")
    if GPIO.input(KEY1_PIN): pass
    else: print("KEY1")
    if GPIO.input(KEY2_PIN): pass
    else: print("KEY2")
    if GPIO.input(KEY3_PIN): pass
    else: print("KEY3")
