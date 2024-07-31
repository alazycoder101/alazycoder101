def worker(id, iterations)
  puts "Worker #{id} started"
  iterations.times do |i|
    # Simulate some CPU-bound work
    result = (1..100).reduce(0) { |sum, num| sum + num }
    puts "Worker #{id}, iteration #{i + 1}" if i % 100 == 0
  end
  puts "Worker #{id} finished"
end

num_threads = 4
iterations_per_thread = 500

threads = []

num_threads.times do |i|
  threads << Thread.new { worker(i, iterations_per_thread) }
end

threads.each(&:join)

puts "All threads finished"
