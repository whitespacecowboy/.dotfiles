#!/usr/bin/env sh

brightnessctl set 5%+
max_bri=$(brightnessctl m)
cur_bri=$(brightnessctl g)
bri_perc=$((cur_bri * 100 / max_bri ))
notify-send -h int:value:$bri_perc "brightness" -t 2000
 
