#!/usr/bin/env sh

wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
cur_vol=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep "[.0-9]*" -o)
vol_perc=$(python <<< "print($cur_vol * 100)")

notify-send -h int:value:$vol_perc "volume" -t 2000
