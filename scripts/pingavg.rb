#!/usr/bin/env ruby

puts `ping -c5 -W1 8.8.8.8`.gsub(/\n/, '').sub(/.*\d\d\d\/(.+)\.\d+\/\d.*/, '\1').rjust(4).slice(0,4)
