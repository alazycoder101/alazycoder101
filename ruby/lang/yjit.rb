at_exit do
  RubyVM::YJIT.dump_exit_locations("my_file.dump")
end
