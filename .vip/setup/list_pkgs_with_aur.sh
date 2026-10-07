#!/bin/bash
pacman -Qe | awk '{print $1}'
