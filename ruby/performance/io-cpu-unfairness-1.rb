require 'net/http'
require 'benchmark/ips'

def perform_request
  uri = URI('https://ifconfig.me/')
  timeout = 1
  Net::HTTP.start('http://ifconfig.me', open_timeout: timeout, read_timeout: timeout, write_timeout: timeout) do |http|
    http.get('/')
  end
end

Benchmark.ips do |x|
  x.config(time: 1, warmup: 0)
  x.report("request") { perform_request }
end
