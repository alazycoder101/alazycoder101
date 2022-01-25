# you can write to stdout for debugging purposes, e.g.
# puts "this is a debug message"

def solution(a)
  # write your code in Ruby 2.2
  size = a.size
  sets = [-1, 1]
  results = []
  (2**(size)).times {|num|
    s = size.times.map{|i| rem=num%2; num=num/2; rem}
    sum = 0
    s.each_with_index{|v, k| sum +=sets[v]*a[k]}
    results << sum.abs
  }
  results.min
end