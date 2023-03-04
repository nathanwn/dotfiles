#!/bin/bash

wallpaper_1="${HOME}/Pictures/wallpapers/uq-jacarandas.jpg"
wallpaper_2="${HOME}/Pictures/wallpapers/uq-jacarandas-3.jpg"

if [[ "$(xrandr --query | grep -c "\bconnected\b")" == "2" ]] \
  && [[ -f "${wallpaper_1}" ]] \
  && [[ -f "${wallpaper_2}" ]]; then
    feh --bg-scale \
       "${wallpaper_1}" \
       "${wallpaper_2}"
fi
