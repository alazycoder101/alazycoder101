require 'objspace'
require 'symbols'
s = Symbols.all_symbols

def check_memory
  s = Symbols.all_symbols
  obj = ObjectSpace.count_objects
  stat = RubyVM.stat

  puts "before == all_symbols: #{s.size}"
  yield
  puts "after == all_symbols: #{Symbol.all_symbol - s}"
  puts "after == all_symbols: #{Symbol.all_symbol - s}"
end

a = []
b = {}

loop {
  sleep(1)

  10_000.times { a << "abc" }

  puts GC.stat(b)[:heap_live_slots]
}
