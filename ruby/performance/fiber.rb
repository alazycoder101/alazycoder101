require 'fiber'
require 'net/http'

def async_get(url)
  Fiber.new do
    uri = URI(url)
    response = Net::HTTP.get_response(uri)
    [url, response.body]
  end
end

urls = [
  'https://api.github.com',
  'https://api.gitlab.com',
  'https://api.bitbucket.org'
]

fibers = urls.map { |url| async_get(url) }

results = fibers.map do |fiber|
  fiber.resume
  fiber
end

while results.any?
  ready, results = results.partition(&:alive?)
  ready.each do |fiber|
    url, body = fiber.resume
    puts "#{url}: #{body.slice(0, 50)}..."
  end
end
