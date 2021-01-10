#!/bin/bash

killall -q polybar

#polybar main 2> /home/geowarin/.cache/poly-main.log & disown
polybar primary & disown
polybar secondary & disown
