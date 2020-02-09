#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x "polybar" >/dev/null; do sleep 1; done

#m=$(xrandr --query | grep " connected" | grep primary | cut -d" " -f1)
#cmd=$(env "MONITOR=$m" polybar --reload main)
#
#if [[ $# -gt 0 ]] && [[ $1 = "block" ]]; then
#	exec "${cmd[@]}"
#else
#	"${cmd[@]}" &
#fi

if type "xrandr"; then
    for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
        MONITOR=$m polybar --reload main &
    done
else
    polybar --reload main &
fi


