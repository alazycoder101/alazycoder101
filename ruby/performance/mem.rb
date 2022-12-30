def test
  a = 'a'
  puts 'test with nil'
  ObjectSpace.define_finalizer(a, proc {|id| puts "Finalizer one on #{id}" })
  nil
end

def test2
  puts 'test without nil'
  a = 'a'
  ObjectSpace.define_finalizer(a, proc {|id| puts "Finalizer a on #{id}" })
end

test
b = test2
test

a = 102.7
b = 95       # Won't be returned
c = 12345678987654321
count = ObjectSpace.each_object(Numeric) {|x| p x }
puts "Total count: #{count}"

trace = TracePoint.new(:raise) do |tp|
    p [tp.lineno, tp.event, tp.raised_exception]
end
#=> #<TracePoint:disabled>

trace.enable
#=> false


GC::Profiler.enable

require 'rdoc/rdoc'

GC::Profiler.report

GC::Profiler.disable

0 / 0
#=> [5, :raise, #<ZeroDivisionError: divided by 0>]
