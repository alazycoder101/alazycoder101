require 'objspace'
ObjectSpace.memsize_of("a")
ObjectSpace.memsize_of("a"*23)
ObjectSpace.memsize_of("a"*24)

size=0
ObjectSpace.each_object{|o| size += ObjectSpace.memsize_of(o) }
puts size/1024

GC.start
GC.count
8.times { Array.new(1_000_000/8) }
puts ObjectSpace.memsize_of(Array.new(1_000_000/8))
