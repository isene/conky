#!/usr/bin/env ruby
# Gets the illuminated fraction of the Moon's disk

class Numeric # NUMERIC CLASS EXTENSION
  def deg
    self * Math::PI / 180
  end
end

require 'date'

@tz    = "+1"               # Time Zone
mp     = 29.530588861
nm     = 2459198.177777778
fm     = nm + mp/2
y      = Time.now.year
m      = Time.now.month
d      = Time.now.day
h      = Time.now.hour
jd     = DateTime.new(y, m, d, h, 0, 0, @tz).ajd.to_f
ph_a   = ((jd - fm) % mp) / mp * 360
mp_ip  = ((1 + Math.cos(ph_a.deg))*50).to_i
ph_a   > 180 ? gs = "+" : gs = "-"
#if mp_ip < 25
#  sym = "○"
#elsif mp_ip < 75
#  gs == "+" ? sym = "◐" : sym = "◑"
#else
#  sym = "●"
#end

#puts "#{sym} #{mp_ip}%#{gs}"
puts "#{mp_ip}%#{gs}"
