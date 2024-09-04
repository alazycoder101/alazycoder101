def sample_method
  puts "Hello, world!"
end

iseq = RubyVM::InstructionSequence.new {|env|
  RubyVM::InstructionSequence.of_method(sample_method)
}

puts iseq.disasm

