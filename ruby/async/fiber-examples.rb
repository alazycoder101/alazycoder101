f = Fiber.new { puts 1; Fiber.yield; puts 2 }

f.resume
# 1

f.resume
# 2

factorial =
Fiber.new do
  count = 1

  loop do
    Fiber.yield (1..count).inject(:*)
    count += 1
  end
end
puts Array.new(5) { factorial.resume }.inspect

# [1, 2, 6, 24, 120]
