# https://brunosutic.com/blog/async-ruby
#
require "open-uri"
puts 'normal'

start = Time.now

URI.open("https://httpbin.org/delay/1.6")
URI.open("https://httpbin.org/delay/1.6")

puts "Duration: #{Time.now - start}"


puts 'with threads'
@counter = 0

start = Time.now

1.upto(2).map {
  Thread.new do
    URI.open("https://httpbin.org/delay/1.6")

    @counter += 1
  end
}.each(&:join)

puts "Duration: #{Time.now - start}"



puts 'with Async'
require "async"
require "async/http/internet"

start = Time.now

Async do |task|
  http_client = Async::HTTP::Internet.new

  task.async do
    http_client.get("https://httpbin.org/delay/1.6")
  end

  task.async do
    http_client.get("https://httpbin.org/delay/1.6")
  end
end

require "async"
require "open-uri"
require "httparty"

start = Time.now

Async do |task|
  task.async do
    URI.open("https://httpbin.org/delay/1.6")
  end

  task.async do
    HTTParty.get("https://httpbin.org/delay/1.6")
  end
end

puts "Duration: #{Time.now - start}"


puts 'advanced'

require "async"
require "open-uri"
require "httparty"
require "redis"
require "net/ssh"
require "sequel"

DB = Sequel.postgres
Sequel.extension(:fiber_concurrency)
start = Time.now

require "async"
require "async/http/internet"
require "redis"
require "sequel"

DB = Sequel.postgres(max_connections: 1000)
Sequel.extension(:fiber_concurrency)
# Warming up redis clients
redis_clients = 1.upto(1000).map { Redis.new.tap(&:ping) }

start = Time.now

Async do |task|
  http_client = Async::HTTP::Internet.new

  1000.times do |i|
    task.async do
      DB.run("SELECT pg_sleep(2)")
      URI.open("https://httpbin.org/delay/1.6")
      redis_clients[i].blpop("abc123", 2)
      sleep 2
    end
  end
end

puts "Duration: #{Time.now - start}s"

puts 'with open-uri'
require "async"
require "open-uri"

start = Time.now

Async do |task|
  task.async do
    URI.open("https://httpbin.org/delay/1.6")
  end

  task.async do
    URI.open("https://httpbin.org/delay/1.6")
  end
end

puts "Duration: #{Time.now - start}"


