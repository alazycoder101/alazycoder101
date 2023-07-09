# leaky.rb
require "memory_profiler"
 
an_array = []
 
report = MemoryProfiler.report do
  11.times do
 
    1000.times { an_array << "A" + "B" + "C" }
    puts "Array is #{an_array.size} items long"
  end
 
  GC.start
end
 
report.pretty_print