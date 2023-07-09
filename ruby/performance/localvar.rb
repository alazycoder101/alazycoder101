require 'benchmark'

n = 100_000_000
Benchmark.bm do |x|
  x.report(:no_local) do
    n.times do
      0.is_a?(Array)
    end
  end

  klass = Array
  x.report(:local) do
    n.times do
      0.is_a?(klass)
    end
  end
end

