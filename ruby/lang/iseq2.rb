# Define a Ruby method
def my_method
  puts "Hello, World!"
end

# Compile the method into an InstructionSequence object
iseq = RubyVM::InstructionSequence.new('my_method')

# List the instructions
puts "Instructions for 'my_method':"
pp iseq.disasm
