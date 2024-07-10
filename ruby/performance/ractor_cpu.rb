def compute_primes
  NR_CORES.times.map do |i|
    Ractor.new(PARTITIONED[i]) do |partition|
      partition.each { |n| prime?(n) }
      nil # implicit return value
    end
  end.each(&:take)
end


def filter_primes
  NR_CORES.times.map do |i|
    Ractor.new(PARTITIONED[i]) do |partition|
      Ractor.yield(partition.filter { |n|
        prime?(n)
      })
    end
  end.flat_map(&:take)
end
