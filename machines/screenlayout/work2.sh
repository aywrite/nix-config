#!/bin/sh
# Set the monitors up
xrandr --output HDMI-2 --mode 3840x2160 --pos 3840x0 --rotate normal --output HDMI-1 --off --output DP-1 --primary --mode 3840x2160 --pos 0x0 --rotate normal --output eDP-1 --mode 1920x1080 --pos 3840x2160 --rotate normal --output DP-2 --off
# Change the keyboard refresh rate
xset r rate 220 40
