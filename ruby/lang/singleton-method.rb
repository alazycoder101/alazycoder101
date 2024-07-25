# singletone method
# ruby singleton-method.rb

class MyClass
  def self.my_method
    puts "class instance method"
  end

  def my_method
    puts "instance method"
  end
end

MyClass.my_method

my_class = MyClass.new
my_class.my_method

def my_class.my_singleton_method
  puts "This is a singleton method"
end

my_class.my_singleton_method

def my_class.my_method
  puts "This is a singleton method overriding the instance method"
end

my_class.my_method
MyClass.new.my_method

class << my_class
  def another_singleton_method
    puts "Another singleton method"
  end
end
my_class.another_singleton_method

class << MyClass
  def my_method
    puts "Another singleton method overriding the instance method"
  end
end
MyClass.my_method
