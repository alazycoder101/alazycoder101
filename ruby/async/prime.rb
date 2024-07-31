# Example of using Ractor for parallel computation
require 'prime'

def calculate_primes(range)
  range.count { |n| n.prime? }
end

r1 = Ractor.new(1..50000) { |range| calculate_primes(range) }
r2 = Ractor.new(50001..100000) { |range| calculate_primes(range) }

puts "Total primes: #{r1.take + r2.take}"