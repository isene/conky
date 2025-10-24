#!/bin/sh
#wttr.in weather tool for conky
#
#USAGE: weather.sh <locationcode>
#
#Modified to use wttr.in (2025)

METRIC=1 #Should be 0 or 1; 0 for F, 1 for C

if [ -z $1 ]; then
    echo
    echo "USAGE: weather.sh <locationcode>"
    echo
    exit 0;
fi

# Set units based on METRIC flag
if [ $METRIC -eq 1 ]; then
    UNITS="m"
else
    UNITS="u"
fi

# Fetch weather from wttr.in and format output
curl --connect-timeout 30 -s "wttr.in/$1?format=%t+%C&${UNITS}" 2>/dev/null | sed 's/+//g'
