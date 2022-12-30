GC.start
puts GC.count
8.times { Array.new(1_000_000/8) }
puts GC.count
require 'objspace'

puts ObjectSpace.memsize_of(Array.new(1_000_000/8))

#bundle exec rails r 'p GC.stat'
