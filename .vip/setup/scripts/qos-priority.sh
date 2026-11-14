#!/bin/bash
tc qdisc add dev enp42s0 root handle 1: htb default 10
tc class add dev enp42s0 parent 1: classid 1:1 htb rate 80mbit ceil 100mbit
tc filter add dev enp42s0 protocol ip parent 1: prio 1 u32 match ip dst 192.168.0.23 flowid 1:1

tc qdisc add dev enp4s0 root handle 2: htb default 20
tc class add dev enp4s0 parent 2: classid 2:1 htb rate 20mbit ceil 50mbit
tc filter add dev enp4s0 protocol ip parent 2: prio 2 u32 match ip dst 192.168.1.167 flowid 2:1

