RubyVM::InstructionSequence.compile_option = { trace_instruction: true }
set_trace_func proc { |event, file, line, id, binding, klass|
  puts "#{event}: #{id} called at #{file}:#{line}"
}

[0, 2].map { |i| i + 1 }
