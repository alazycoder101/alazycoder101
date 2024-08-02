# Create a new TracePoint that triggers after a garbage collection event
trace = TracePoint.new(:gc_start) do |tp|
  # This block will be executed when a garbage collection starts
  puts "Garbage collection started at #{tp.lineno}:#{tp.event}"
end

# Enable the trace point
trace.enable

# Your application code here, which will trigger GC from time to time
# For example, creating many objects to trigger GC
100_000.times do
  Object.new
end

# Disable the trace point when done
trace.disable
