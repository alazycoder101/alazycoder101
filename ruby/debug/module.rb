# frozen_string_literal: true

require 'debug'

module Test

  MODULE_NAME = 'test'

  local_var = 'a'
  @instance_var = 'b'
  @@class_instance_var = 'c'

  def foo
    puts 'foo'
  end

  puts "id at Ruby level: self.object_id=#{object_id}"
  puts "id at C level: self.inspect=#{inspect} (name only for Module with name)"
  puts "ObjectSpace._id2ref(object_id)==self: #{ObjectSpace._id2ref(object_id)==self}"
  debugger


  puts '`info local` to show locals'
  puts '`info consts` to show constants'
  puts '`info global` to show globals'


  def bar
    puts 'bar'
  end
end

something = Module.new do
  MY_MODULE_NAME = 'anonymous/noname'

  local_var = 'anonymous/a'
  @instance_var = 'anonymous b'

  def foo
    puts local_var
  end

  puts "id at Ruby level: self.object_id=#{object_id}"
  puts "id at C level: self.inspect=#{inspect}"
  puts "ObjectSpace._id2ref(object_id)==self: #{ObjectSpace._id2ref(object_id)==self}"

  debugger

  def bar
    puts @instance_var
  end
end

puts Marshal.dump(Test)

debugger
Marshal.dump(something)
