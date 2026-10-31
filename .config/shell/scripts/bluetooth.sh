#!/usr/bin/env sh

status=$(playerctl status)
bluetoothctl disconnect BC:3F:4E:D6:EB:3E
bluetoothctl connect BC:3F:4E:D6:EB:3E

if [ $status = "Playing" ]; then
	sleep 2
	playerctl play
fi
