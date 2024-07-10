code = <<-RUBY
  def hello
    puts "Hello, World!"
  end
RUBY

# Compile the code to bytecode
iseq = RubyVM::InstructionSequence.new(code)

# Disassemble the bytecode
puts iseq.disasm
