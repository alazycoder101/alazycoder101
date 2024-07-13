require 'ruby-prof'

RubyProf.start

# Your code that you want to profile
def my_method
  # Your code here
end

my_method

result = RubyProf.stop
printer = RubyProf::FlatPrinter.new(result)
printer.print($stdout)


require 'objspace'
pp ObjectSpace.count_imemo_objects
