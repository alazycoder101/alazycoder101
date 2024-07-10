require 'net/http'
require 'uri'

TIMES = 5

def http_get
  uri = URI.parse('https://www.ruby-lang.org')
  Net::HTTP.get_response(uri)
end

def http_get_sync
  TIMES.times { http_get }
end
