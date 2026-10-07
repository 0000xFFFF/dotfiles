#!/bin/bash
pacman -Qn | awk '{print $1}'
