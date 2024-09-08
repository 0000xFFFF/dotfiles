#!/bin/bash

while true; do
        NEW_FILE="blank_$RANDOM.zero"
        if [ -f "$NEW_FILE" ]; then
                continue
        fi
        df -h .
        cp -v blank1.zero "$NEW_FILE"
        if [ $? == 1 ]; then
                break
        fi
done
