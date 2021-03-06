#! /usr/bin/env bash

export DISPLAY=':0.0'

# if a screen is already connected, just exit.
xrandr -q | grep -q '\.[0-9]\+\*'
if [[ $? = 0 ]]; then
    echo "$(date) screen already connected, exiting..."
    exit 0
fi


echo "$(date) waiting for a screen to be connected..."
connected_screen=''
while [[ -z "${connected_screen}" ]]; do

    sleep 5

    connected_screen="$(xrandr -q | awk '/ connected /{print $1}')"
    # HDMI1

done
echo "$(date) ${connected_screen} connected"


screen_default_mode="$(
    xrandr -q \
        | sed -n "/^${connected_screen}/,/+ /p" \
        | awk '/\+ /{print $1}'
)"
# 1920x1080
echo "$(date) ${connected_screen} default mode: ${screen_default_mode}"


xrandr --output "${connected_screen}" --mode "${screen_default_mode}"
