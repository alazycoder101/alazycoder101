def solution(a)
  # write your code in Ruby 2.2
  smallest = 1
  a.sort.each do |val|
    break if val > smallest
    smallest += 1 if val == smallest
  end
  return smallest
end
