trace = TracePoint.new(:raise) do |tp|
    p [tp.lineno, tp.event, tp.raised_exception]
end

trace = TracePoint.new(:call) do |tp|
    p [tp.lineno, tp.defined_class, tp.method_id, tp.event]
end
#=> #<TracePoint:disabled>

trace.enable
#=> false

puts "Hello, TracePoint!"
#=> #<TracePoint:disabled>

0 / 0


trace = TracePoint.new(:call, :return) do |tp|
  method = "#{tp.defined_class}##{tp.method_id}"
  case tp.event
  when :call
    puts "Entering: #{method} at #{tp.path}:#{tp.lineno}"
    puts "  Arguments: #{tp.binding.local_variables.map { |v| [v, tp.binding.local_variable_get(v)] }.to_h}"
  when :return
    puts "Exiting:  #{method} with value: #{tp.return_value}"
  end
end

trace.enable
# Your code here
trace.disable
