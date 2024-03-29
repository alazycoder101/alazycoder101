#!/usr/bin/env ruby

require 'set'
require 'json'

if ARGV.length != 3
  puts "Usage: detect_leaks [FIRST.json] [SECOND.json] [THIRD.json]"
  exit 1
end

first_addrs = Set.new
third_addrs = Set.new

# Get a list of memory addresses from the first dump
File.open(ARGV[0], "r").each_line do |line|
  parsed = JSON.parse(line)
  first_addrs << parsed["address"] if parsed && parsed["address"]
end

# Get a list of memory addresses from the last dump
File.open(ARGV[2], "r").each_line do |line|
  parsed = JSON.parse(line)
  third_addrs << parsed["address"] if parsed && parsed["address"]
end

diff = []

# Get a list of all items present in both the second and
# third dumps but not in the first.
File.open(ARGV[1], "r").each_line do |line|
  parsed = JSON.parse(line)
  if parsed && parsed["address"]
    if !first_addrs.include?(parsed["address"]) && third_addrs.include?(parsed["address"])
      diff << parsed
    end
  end
end

# Group items
diff.group_by do |x|
  [x["type"], x["file"], x["line"]]
end.map do |x,y|
  # Collect memory size
  [x, y.count, y.inject(0){|sum,i| sum + (i['bytesize'] || 0) }, y.inject(0){|sum,i| sum + (i['memsize'] || 0) }]
end.sort do |a,b|
  b[1] <=> a[1]
end.each do |x,y,bytesize,memsize|
  # Output information about each potential leak
  puts "Retained #{y} #{x[0]} objects of size #{bytesize}/#{memsize} at: #{x[1]}:#{x[2]}"
end

# Also output total memory usage, because why not?
memsize = diff.inject(0){|sum,i| sum + (i['memsize'] || 0) }
bytesize = diff.inject(0){|sum,i| sum + (i['bytesize'] || 0) }
puts "\n\nTotal Size: #{bytesize}/#{memsize}"