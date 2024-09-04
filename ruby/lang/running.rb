def current_method_info
  method = RubyVM::Env.method
  file = RubyVM::Env.file
  line = RubyVM::Env.line
  [method.name, file, line]
end

puts current_method_info
