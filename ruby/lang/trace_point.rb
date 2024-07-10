trace_point = TracePoint.new(:call, :return) do |tp|
  if tp.event == :call
    puts "Entering: #{tp.defined_class}##{tp.method_id}"
  elsif tp.event == :return
    puts "Leaving: #{tp.defined_class}##{tp.method_id}"
  end
end

trace_point.enable

def my_method
  puts "Doing something important"
end

my_method