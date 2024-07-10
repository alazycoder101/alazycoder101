require 'etc'


NR_CORES = Etc.nprocessors
RANGE = 1..10_000
PARTITIONED = RANGE.group_by { |i| i % NR_CORES }.values.zip.flat_map { |it| it }


def prime?(n)
  n > 1 && (2...n).none? { |i| n % i == 0 }
end


def compute_primes
  NR_CORES.times.map do |i|
    Thread.new do
      partition = PARTITIONED[i]
      partition.each { |n| prime?(n) }
    end
  end.each(&:join)
end


def filter_primes
  result = []
  NR_CORES.times.map do |i|
    Thread.new do
      partition = PARTITIONED[i]
      partition.each { |n|
        # GIL prevents Race Condition, but not in JRuby for example
        result << n if prime?(n)
      }
    end
  end.each(&:join)
  # puts result.size ## In CRuby always 1229, in JRuby <= 1229
end
