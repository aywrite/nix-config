#!/bin/bash
(sleep "$1" && notify-send --hint=string:bar:baz -u critical timer "Your $1 second timer is done" --app-name=POMODORO) &
