require('debug')
puts "root: #{self}" # self

module MyModule
  puts "MyModule: #{self}" # self
end

class MyClass
  puts "MyClass: #{self}" # self

  def initialize
    puts "initialize: #{self}" # self
  end

  def method
    puts "method: #{self}" # self
  end

  def run_block
    yield
  end
end

c = MyClass.new
c.method
puts "c.instance_eval { self }: #{c.instance_eval { self }}"
puts MyClass.class_eval { self } # self
puts MyModule.module_eval { self } # self

# proc
a = proc { puts "proc: #{self}" }
a.call

b = -> { puts "lambda: #{self}" }
b.call
def run(c)
  puts "run: #{self}"
  c.run_block do
    puts "block: #{self}"
  end
end
run(c)

m = MyClass.instance_method(:method)
m.bind_call(c)
