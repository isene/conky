#!/usr/bin/env ruby

output = `ping -c5 -W1 8.8.8.8 2>&1`
if output =~ /min\/avg\/max\/mdev = [\d.]+\/([\d.]+)\//
  avg = $1.to_f.round.to_s
  puts avg.rjust(4).slice(0,4)
else
  puts "   -"
end
