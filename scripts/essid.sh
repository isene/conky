#!/bin/bash

essid=$(iw dev | awk '/ssid/ {print $2}')
essidlength=${#essid}

if [ $essidlength -lt 13 ]
then
	echo $essid
else
	echo $essid | cut -c 1-12 | sed "s/$/../"
fi
