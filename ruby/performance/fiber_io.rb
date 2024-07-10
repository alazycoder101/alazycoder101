require 'net/http'
require 'uri'
require 'fiber'
require 'async'


TIMES = 5


def http_get
  uri = URI.parse("https://www.ruby-lang.org")
  Net::HTTP.get_response(uri)
end


def http_get_fiber_scheduler
  Async do
    TIMES.times do
      Fiber.schedule do
        http_get
      end
    end
  end.wait
end
