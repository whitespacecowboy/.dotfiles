#!/usr/bin/env sh

current_brightness=$(brightnessctl g)
max_brightness=$(brightnessctl m)

if [ $current_brightness -gt $(( max_brightness / 20 )) ]; then
	brightnessctl set 5%-
fi
# [ $(brightnessctl g) -gt $(( $(brightnessctl m) / 20 )) ] && brightnessctl set 5%-
