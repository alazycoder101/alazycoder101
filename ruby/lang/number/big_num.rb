puts "0.1 + 0.2 = #{0.1 + 0.2}"

puts "(2e+16 + 0.5) == (2e+16 + 0.0) + 0.5 => #{(2e+16 + 0.5) == (2e+16 + 0.0) + 0.5}"

puts 1e308
puts 1e309

def mean(a, b)
  (a + b) / 2
end

puts mean(0.1, 0.2)
puts mean(1e308, 1e308)

def check_max
  if RUBY_VERSION >= "3.0"
    puts 'no limit to Integer'
    puts "Float::Max=#{Float::MAX}"
    puts "Float::INFINITY=#{Float::INFINITY}"
  else
    puts "Float::Max=#{Float::MAX}"
    puts "Integer::MAX=#{Integer::MAX}"
  end
end

check_max

if RUBY_VERSION >= "3.0"
  def safe_mean(a, b)
    if a.is_a?(Integer) && b.is_a?(Integer)
      # Check for potential overflow when adding two integers
      max_int = Integer::MAX
      if a > max_int / 2.0 || b > max_int / 2.0
        return "Overflow error"
      end
    elsif a.is_a?(Float) || b.is_a?(Float)
      # Check for potential overflow when adding two floats
      if a > Float::INFINITY / 2.0 || b > Float::INFINITY / 2.0
        return "Overflow error"
      end
    end

    # Calculate the mean
    mean = (a + b) / 2.0

    return mean
  end
  # Example usage
  result = safe_mean(1e+308, 1e+308)
  if result != "Overflow error"
    puts "The mean is: #{result}"
  else
    puts "Error: Mean calculation would cause overflow."
  end
else
  def safe_mean(a, b)
    (a / 2.0 + b / 2.0) * 2.0
  end
  result = safe_mean(1e+308, 1e+308)
end

