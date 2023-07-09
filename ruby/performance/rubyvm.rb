RubyVM::AbstractSyntaxTree.of(proc {1 + 2})

def hello
  puts "hello, world"
end

RubyVM::AbstractSyntaxTree.of(method(:hello))

RubyVM::AbstractSyntaxTree.parse("x = 1 + 2")


RubyVM::InstructionSequence.compile("a = 1 + 2")

p = proc { num = 1 + 2 }
puts RubyVM::InstructionSequence.disasm(p)


def hello
  puts "hello, world"
end

puts RubyVM::InstructionSequence.disasm(method(:hello))

RubyVM::InstructionSequence.compile("a = 1 + 2")
puts RubyVM::InstructionSequence.compile('1 + 2').disasm
puts RubyVM::InstructionSequence.compile("1 + 2").eval

iseq = RubyVM::InstructionSequence.compile('num = 1 + 2')
puts iseq.label
puts iseq.first_lineno
puts iseq.path
