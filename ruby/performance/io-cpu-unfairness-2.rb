require 'net/http'
require 'benchmark/ips'

Thread.new do
  Thread.current.name = 'cpu-heavy'
  foo = 0
  loop do
    foo += 1
    foo = 0 if foo > 1_000_000_000_000
  end
end

def perform_request
  timeout = 10
  Net::HTTP.start('ifconfig.me', open_timeout: timeout, read_timeout: timeout, write_timeout: timeout) do |http|
    http.get('/')
  end
end

Benchmark.ips do |x|
  x.config(time: 1, warmup: 0)
  x.report('request') { perform_request }
end
