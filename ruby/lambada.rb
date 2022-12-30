# https://www.rubyguides.com/2016/02/ruby-procs-and-lambdas/
say_something = -> { puts "This is a lambda" }
say_something.call
say_something.()
say_something[]
say_something.===

times_two = ->(x) { x * 2 }
times_two.call(10) # => 20
t = Proc.new { |x,y| puts "I don't care about arguments!" }
t.call # => "I don't care about arguments!"

# Should work
my_lambda = -> { return 1 }
puts "Lambda result: #{my_lambda.call}"

# Should raise exception
my_proc = Proc.new { return 1 }
puts "Proc result: #{my_proc.call}"

def call_proc
  puts "Before proc"
  my_proc = Proc.new { return 2 }
  my_proc.call
  puts "After proc"
end

p call_proc # Prints "Before proc" but not "After proc"

def return_binding
  foo = 100
  binding
end

# Foo is available thanks to the binding,
# even though we are outside of the method
# where it was defined.
puts return_binding.class
puts return_binding.eval('foo')

# If you try to print foo directly you will get an error.
# The reason is that foo was never defined outside of the method.
puts foo
