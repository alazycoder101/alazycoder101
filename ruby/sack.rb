def sack(arr, target)

  arr.sort!
  size = arr.size
  sum = arr.sum
  result = []
  left = []
  half = sum / 2
  pack_sum = 0
  for i in 1..size
    num = left.pop
    if pack_sum + num < half
      result.push(num)
      pack_sum += num
    else
      diff = pack_sum + num - half
    end
  end
end

sack([1,2,4,6,9])
