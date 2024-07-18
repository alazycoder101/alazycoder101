require 'net/http'
require 'uri'

TIMES = 5

def http_get
  uri = URI.parse('http://ifconfig.me')
  puts Net::HTTP.get_response(uri)
end

def http_get_sync
  TIMES.times { |i| puts i; http_get }
end

http_get_sync
