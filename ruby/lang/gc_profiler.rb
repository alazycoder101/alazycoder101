# frozen_string_literal: true

def track_gc
  GC::Profiler.enable

  yield

  GC::Profiler.report
  p GC::Profiler.raw_data
  GC::Profiler.clear
  GC::Profiler.disable
end

track_gc do
  100_000.times do
    Object.new
  end
end

track_gc do
  [1, 2, 3].each { |i| puts i }
end

array = 1 .. 100_000
another_array = ''
track_gc do
  another_array = array.map { |i| i * i }
end
