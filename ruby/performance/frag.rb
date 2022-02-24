# https://gist.github.com/mperham/ac1585ba0b43863dfdb0bf3d54b4098e
Thread.abort_on_exception = true

require 'rbconfig'

puts RbConfig::CONFIG["configure_args"]

THREAD_COUNT = (ENV["T"] || 10).to_i
Threads = []
Strings = []
Threads.clear

REQUEST_COUNT = (ENV["R"] || 10).to_i
STRING_COUNT = (ENV["S"] || 1_000).to_i
CLEANUP = (ENV["C"] || 10).to_i

srand(1234)

def frag
  saver = []
  # requests
  REQUEST_COUNT.times do |idx|

    # each request allocates 1000 strings, then discards 90%
    STRING_COUNT.times do |x|
      # allocate a random sized heap string
      s = 'a' * ((rand(4000) * 10) + 97)
      saver << s
    end

    # now delete random elements to create holes in the heap
    STRING_COUNT.times do
      saver.delete_at(rand(saver.size)) if rand < 0.9
    end

    GC.start if idx % CLEANUP == 0
  end

  total = saver.inject(0) {|memo, str| memo += str.bytesize }
  #print "Thread #{Thread.current.object_id.to_s(36)} has #{total / (1024 * 1024)}MB\n"
  Strings << saver
  total
end

THREAD_COUNT.times do
  Threads << Thread.new(&method(:frag))
end

strsize = 0
Threads.each do|t|
  strsize += t.value
end
Threads.clear
GC.start

puts "Total string size: #{strsize / (1024 * 1024)}MB"
puts `ps aux | grep #{$$}` if RUBY_PLATFORM =~ /darwin/

IO.foreach("/proc/#{$$}/status") do |line|
  print line if line =~ /VmRSS/
end if RUBY_PLATFORM =~ /linux/
