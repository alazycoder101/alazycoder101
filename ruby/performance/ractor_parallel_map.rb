def parallel_map(array, num_ractors = 4)
  ractors = num_ractors.times.map do
    Ractor.new do
      while item = Ractor.receive
        Ractor.yield([item, yield(item)])
      end
    end
  end

  results = []
  array.each_with_index do |item, index|
    ractors[index % num_ractors].send(item)
  end

  num_ractors.times { ractors.sample.send(nil) }

  while result = Ractor.select(*ractors)
    results << result.value
  end

  results.sort_by(&:first).map(&:last)
end

result = parallel_map(1..100) { |n| n * n }
puts result.take(10)