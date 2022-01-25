# common.rb
require "get_process_mem"

def print_usage(description)
  mb = GetProcessMem.new.mb
  puts "#{ description } - MEMORY USAGE(MB): #{ mb.round }"
end

def print_usage_before_and_after
  print_usage("Before")
  yield
  print_usage("After")
end

def random_name
  (0...20).map { (97 + rand(26)).chr }.join
end
