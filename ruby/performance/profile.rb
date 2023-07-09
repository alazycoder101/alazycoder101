# profile.rb
require "memory_profiler"
require_relative "./people"

report = MemoryProfiler.report do
  run(1000)
end

report.pretty_print(to_file: "profile.txt")


# start the daemon, and let us know the file to which it reports
puts MemoryProfiler.start_daemon( :limit=>5, :delay=>10, :marshall_size=>true, :sort_by=>:absdelta )

5.times do
  blah = Hash.new([])

  # compare memory space before and after executing a block of code
  rpt  = MemoryProfiler.start( :limit=>10 ) do
    # some activities likely to create object references
    100.times{ blah[1] << 'aaaaa' }
    1000.times{ blah[2] << 'bbbbb' }
  end

  # display the report in a (slightly) readable form
  puts MemoryProfiler.format(rpt)

  sleep 7
end

# terminate the daemon
MemoryProfiler.stop_daemon
