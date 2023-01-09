# Ruby freeze

# Number
num = 1.freeze
num += 1              # No Error

# String
name = 'Tom'.freeze
name << ' Hardy'      # FrozenError

# Array
texts = ['a', 'b', ['c', 'd'], {e: 'f'}].freeze
texts[0] << 'b'       # No Error
texts[1].replace('c') # No Error
texts[2] << 'e'
texts[3].merge!({g: 'h'})
texts                 # => ["ab", "c", ["c", "d", "e"], {:e=>"f", :g=>"h"}]
texts[0] = 'b'        # FrozenError

hash = {a: 'b', c: 'd', e: ['f']}.freeze
hash[:a] << 'b'
hash[:c].replace('dd')
hash[:e] << 'g'
hash                  # => {:a=>"bb", :c=>"dd", :e=>["f", "g"]}
hash[:a] = 1          # FrozenError

# class object free

class A
  attr_accessor :array
  def initialize
    @array = []
    freeze
  end

  def test
    puts 'test from A'
  end
end

class B < A; freeze; end

a = A.new
b = B.new
# instance object frozen inherited due to the same initialize
puts "a.frozen? = #{a.frozen?}"
puts "b.frozen? = #{b.frozen?}"
puts "a.array.frozen? = #{a.array.frozen?}"
# change instance var even object is frozen
#a.array = [1] # Frozen Error
puts "a.array=#{a.array}"
a.array << 11
puts "a.array=#{a.array}"
a.array.freeze
puts "a.array.frozen? = #{a.array.frozen?}"
# a.array << 2 $# FrozenError

# a.define_singleton_method(:test2) { puts 'test from A instance' } # FrozenError

puts "A.frozen? = #{A.frozen?}"
A.freeze
puts "A.frozen? = #{A.frozen?}"
puts "B.frozen? = #{B.frozen?}"

class C < A; end
puts "C.frozen? = #{C.frozen?}"

