def pack(arr)
  case arr.size
  when 1
    arr[0]
  else
    pack(arr[1..arr.size])
  end
end

puts pack([1,2,3]).inspect
