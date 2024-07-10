trace_func = proc do |event, file, line, id, binding, klass|
  puts "Event: #{event}, File: #{file}, Line: #{line}, ID: #{id}, Class: #{klass}"
end

set_trace_func trace_func

# Your Ruby code here, for example:
def my_method
  puts "Hello, World!"
end

my_method
