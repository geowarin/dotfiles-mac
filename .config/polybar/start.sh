#!/bin/bash

killall -q polybar

polybar primary 2> /home/geowarin/.cache/poly-main.log & disown
#polybar primary & disown
polybar secondary & disown
