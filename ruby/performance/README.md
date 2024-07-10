# IO/CPU unfairness
https://ivoanjo.me/blog/2023/02/11/ruby-unexpected-io-vs-cpu-unfairness
```bash
ruby 3.1.2p20 (2022-04-12 revision 4491bb740a) [arm64-darwin21]

ruby io-cpu-unfairness-1.rb
Calculating -------------------------------------
             request      0.861  (± 0.0%) i/s -      1.000  in   1.161163s
ruby io-cpu-unfairness-2.rb
Calculating -------------------------------------
             request      0.602  (± 0.0%) i/s -      1.000  in   1.660690s

```

# heap

### Solution 1: Virtual memory
The programs running on our computers use Virtual Memory. The value of the pointer is not the physical location in the RAM; instead, the CPU translates the address on the fly. This decoupling allows defragmenting the RAM without moving anything but requires dedicated hardware that we do not have on our microcontrollers.

### Solution 2: Optimized allocators
Either as part of the standard library or as a linked library, C++ programs running on a computer embeds a heap allocator that is much more efficient than what we have on our Arduinos.

The most common optimization is to gather small blocks into bins: one bin for blocks of 4 bytes, one bin for 8 bytes, etc. Thanks to this technique the small objects don’t contribute to and are not affected by the fragmentation.

### Solution 3: Short string optimization
Even if the C++ standard doesn’t mandate it, all implementations of std::string support the “Small String Optimization,” or SSO. std::string stores short strings locally and only uses the heap for long strings.

By reducing the number of small objects in the heap, the SSO reduces the fragmentation. Unfortunately, the String class doesn’t perform SSO in Arduino.

### Solution 4: Heap compacting
In languages with managed memory, the garbage collector moves the memory blocks to squash the holes.

We cannot use this technique in C++ because moving a block would change its address, so all pointers to this block would be invalid.

### Solution 5: Memory pool
Instead of allocating many small blocks, a program can allocate only one big block and divide it as it needs. Within this block, the program is free to use any allocation strategy.

For example, ArduinoJson implements this technique with DynamicJsonBuffer.

# trace
```bash
readelf -n $(which ruby) | grep Name
brew update && brew install binutils

otool -l test.o
objdump
```
# dtrace
```bash
wrk -c 20 -d 10 -t 10 --latency http://localhost:9292

sudo dtrace -p 95059 -s gvl.d
sudo dtrace -p 95059 -n 'ruby::vm-gvl-acquire { @waits = quantize(arg0) }'
# time spent on gvl
sudo dtrace -p 11864 -n 'ruby::vm-gvl-acquire { start[tid] = timestamp } ruby::vm-gvl-release { @total[tid] = sum((timestamp - start[tid])) }'
```

```ruby
#!/usr/bin/env ruby
require 'webrick'
server = WEBrick::HTTPServer.new(Port: 8080)
server.mount_proc('/') { |req, res| res.body = 'Hi!' }
trap('INT') { server.shutdown }
server.start
```


```ruby
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
```

Tools
---

1. https://github.com/Shopify/heap-profiler
2. https://github.com/csfrancis/harb

1. http://stratus3d.com/blog/2020/08/11/effective-debugging-of-memory-leaks-in-ruby/
1. https://blog.appsignal.com/2022/08/10/a-deep-dive-into-memory-leaks-in-ruby.html
1. https://www.spacevatican.org/2019/5/4/debugging-a-memory-leak-in-a-rails-app/
1. https://www.therubyonrailspodcast.com/394
1. https://balazs.kutilovi.cz/posts/dtracing-the-ruby-gvl/
1. https://balazs.kutilovi.cz/posts/notes-from-rubyconf-au-talks/
1. https://www.joyfulbikeshedding.com/blog/2019-01-31-full-system-dynamic-tracing-on-linux-using-ebpf-and-bpftrace.html
1. https://cpp4arduino.com/2018/11/06/what-is-heap-fragmentation.html
