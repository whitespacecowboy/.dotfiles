#!/usr/bin/env sh

cur_bri=$(brightnessctl g)
max_bri=$(brightnessctl m)

if [ $cur_bri -gt $(( max_bri / 20 )) ]; then
	brightnessctl set 5%-
fi

cur_bri=$(brightnessctl g)

bri_perc=$((cur_bri * 100 / max_bri ))
notify-send -h int:value:$bri_perc "brightness" -t 2000
