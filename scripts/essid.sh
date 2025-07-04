#!/bin/bash

# Get ESSID of active interface
essid=$(iw dev | awk '/ssid/ {print $2}')
essidlength=${#essid}

# Shorten ESSID if needed
if [ $essidlength -lt 9 ]; then
    display_essid=$essid
else
    display_essid=$(echo $essid | cut -c 1-8)..
fi

# Get external IP (with timeout and silent flags)
ip=$(curl -4 -s --max-time 2 ifconfig.me)

# Output for Conky (single line or split with \n if preferred)
echo "$display_essid $ip"

