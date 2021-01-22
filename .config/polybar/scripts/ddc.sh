#!/bin/sh

t=0

brightness() {
    ddcutil setvcp 10 $1 -d 1 --async &> /dev/null
    ddcutil setvcp 10 $1 -d 2 --async &> /dev/null
}

toggle() {
    t=$(((t + 1) % 2))
    if [ $t -eq 0 ]; then
        brightness 20
    else
        brightness 50
    fi
}


trap "toggle" USR1

while true; do
    if [ $t -eq 0 ]; then
        echo " "
    else
        echo " "
    fi
    sleep 1 &
    wait
done