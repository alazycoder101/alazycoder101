class A
  @a = 'A'
  @@a = 'B'
  a = 'func'

  puts @a

  class_eval <<-CODE, __FILE__, __LINE__ + 1
    def a#{a}
      puts '#{a}'
    end
  CODE

  instance_eval <<-CODE, __FILE__, __LINE__ + 1
    def b#{a}
      puts '#{a}'
    end
  CODE

  define_method a do
    @a
  end

  def initialize
    @a = 'C'
    @@a = 'D'
  end

  def self.a
    @a
  end

  def a
    @a
  end
end

p A.class_variables
p A.class_variable_get(:@@a)

puts "A.a=#{A.a}"
a = A.new

p 'A.instance_variables'
p A.instance_variables
p A.instance_variable_get(:@a)
p 'A.class_variables'
p A.class_variables
p A.class_variable_get(:@@a)

p 'a.instance_variables'
p a.instance_variables
p a.instance_variable_get(:@a)

puts a.func
puts a.a
puts '-'*100
puts a.afunc
puts a.bfunc
