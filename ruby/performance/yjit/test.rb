def get(obj, idx)
  obj[idx]
end

puts get([0, 1, 2], 1)
puts get({ a: 1, b: 2 }, :a)

puts RubyVM::InstructionSequence.disasm(method(:get))
