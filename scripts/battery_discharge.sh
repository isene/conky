#!/usr/bin/env bash

# Echos battery discharge rate

bat_discharge=$(cat /sys/class/power_supply/BAT0/current_now)
bat_watts=$(echo "scale=1;$bat_discharge/100000" | bc)
bat_10_lim=$(echo "$bat_discharge/100000" | bc)
if [ "$bat_10_lim" -lt 10 ]
	then
		echo "" $bat_watts
	else
		echo $bat_watts
fi

