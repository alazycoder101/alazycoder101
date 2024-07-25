code = <<-RUBY
  def example_method(x)
    y = x + 1
    puts y
  end
RUBY

def compile(code)
  puts "compiling:"
  puts code
  iseq = RubyVM::InstructionSequence.compile(code)
  puts "compiled:"
  puts iseq.disasm
  puts '-'*40
end

compile <<-RUBY
  1
RUBY

compile <<-RUBY
  1 + 1
RUBY

compile <<-RUBY
  def example_method(x)
    y = x + 1
  end
RUBY

compile <<-RUBY
  module Module1
    def example_method(x)
      puts :moduel1
    end
  end

  module Module2
    def example_method(x)
      puts :moduel2
    end
  end

  class MyClass
    include Module1
    extend Module2

    def example_method(x)
      puts :class
    end
  end
RUBY

TracePoint.trace(:end) do |tp|
  method_name = tp.method_id
  klass = tp.self
  iseq = RubyVM::InstructionSequence.of(klass.instance_method(method_name))
  puts "Method #{klass}##{method_name} compiled:"
  puts iseq.disasm
end

# Define a method to trigger the TracePoint
def test_method
  puts "Hello, World!"
end
