require 'async'
require 'async/barrier'
require 'async/http'

TIMES = 5

def http_get_non_blocking
  Async do
    url = Async::HTTP::Endpoint.parse("https://www.ruby-lang.org")
    client = Async::HTTP::Client.new(url)
    barrier = Async::Barrier.new

    TIMES.times do
      barrier.async do
        client.get('/').finish
      end
    end
    barrier.wait
  ensure
    client&.close
  end
end
