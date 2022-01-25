def test
  nums = [1, 2, 3, 4, 5, 6]
  nums.sort
  indexes = []
  sum = nums.sum
  sum1 = 0
  size = nums.size
  nums.each_with_index do |v, i|
    for j in i+1..size-1 do
      puts j
      tmp = sum1 + nums[j]
      if 2*tmp < sum
        sum1 += nums[j]
        indexes << j
      else
        puts "sum1=#{sum1}"
        sum1 -= nums[indexes.shift]
      end
    end
  end
  puts indexes.inspect
end

test
