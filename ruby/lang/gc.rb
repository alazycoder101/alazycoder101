require 'debug'
module GCProfiler
  def self.enable
    @callbacks = []
    GC::Profiler.enable

    def self.after_gc
      # This method will be called after each GC
      puts "Garbage collection has completed."
      @callbacks.each { |callback| callback.call }
    end

    # Define a callback that will be called after each GC run
    GC::Profiler.clear
    debugger
    GC::Profiler.add(method(:after_gc))

    # Add a method to register callbacks that you want to be called after GC
    def self.add_callback(&block)
      @callbacks << block
    end
  end

  def self.disable
    GC::Profiler.disable
    @callbacks = []
  end
end

# Enable GC profiling and define a callback
GCProfiler.enable
GCProfiler.add_callback do
  # This block will be executed after each GC
  puts "Callback: Time of GC: #{Time.now}"
end

# Your application code here, which will trigger GC from time to time
# For example, creating many objects
100_000.times do
  Object.new
end

# Disable GC profiling when done
GCProfiler.disable
