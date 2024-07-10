require 'net/http'

Thread.main.name = 'main'

# CPU
def count
  foo = 0
  loop do
    foo += 1
    break if foo > 1_000_000
  end
end

# IO
def perform_request
  timeout = 5
  Net::HTTP.start('ifconfig.me', open_timeout: timeout, read_timeout: timeout, write_timeout: timeout) do |http|
    http.get('/')
  end
end

def make_threads(num = 5)
  num.times.map do |i|
    Thread.new do
      # Set the name of the new thread
      Thread.current.name = "Worker Thread #{i}"
      puts "Started in #{Thread.current.name}"
      yield
      puts "Finished in #{Thread.current.name}"
    end
  end
end

def test_thread(num)
  # binding.irb
  puts "Running in #{Thread.current.name}"

  ts = make_threads(num) do
    yield
  end

  sleep 1
  puts 'Main thread is running after 1 seconds'

  # Join the thread to ensure it has finished before the main thread exits
  ts.each(&:join)
  puts 'Main thread is done after joining with the worker thread'
end

puts '-' * 80
puts 'sleep'
test_thread(5) do
  sleep(3)
end

puts '-' * 80
puts 'CPU: count'
test_thread(5) do
  count
end

puts '-' * 80
puts 'IO: HTTP request'
test_thread(5) do
  perform_request
end

puts '-' * 80
puts 'IO: File'
test_thread(5) do
  File.write('/dev/null', '200000' * 1_000_000)
  # sleep(10)
end
