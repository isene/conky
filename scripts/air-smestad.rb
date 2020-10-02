#!/usr/bin/env ruby
# Gets air quality number from Oslo/Smestad

puts `air-quality find smestad`.sub(/.*Quality: (\d*).*/m, '\1')
