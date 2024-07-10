RANGE = 1..10_000


def prime?(n)
  n > 1 && (2...n).none? { |i| n % i == 0 }
end


def compute_primes
  RANGE.each { |i| prime?(i) }
end


def filter_primes
  RANGE.select { |i| prime?(i) }
end
