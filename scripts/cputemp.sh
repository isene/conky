#!/bin/bash

let t0=`cat /sys/class/thermal/thermal_zone0/temp`
let t1=`cat /sys/class/thermal/thermal_zone1/temp`
let t2=`cat /sys/class/thermal/thermal_zone2/temp`
let t3=`cat /sys/class/thermal/thermal_zone3/temp`
let t4=`cat /sys/class/thermal/thermal_zone4/temp`
let t5=`cat /sys/class/thermal/thermal_zone5/temp`
let t6=`cat /sys/class/thermal/thermal_zone6/temp`
let t7=`cat /sys/class/thermal/thermal_zone7/temp`
let t8=`cat /sys/class/thermal/thermal_zone8/temp`
let t9=`cat /sys/class/thermal/thermal_zone9/temp`

let t=$t0+$t1+$t2+$t3+$t4+$t5+$t6+$t7+$t8+$t9
let t=$t/10000

echo $t"°"

#echo $((`cat /sys/class/thermal/thermal_zone8/temp`/1000))"°"
