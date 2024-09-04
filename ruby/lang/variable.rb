module MyModule
  variable = 1
  @variable = 2
  @@variable = 3

  def self.my_method
    puts 'self.my_method'
  end

  def my_method
    puts 'my_method'
  end

  define_method(:my_method) do
    puts 'my defined method'
  end

  define_singleton_method(:my_method) do
    puts 'my defined singleton method'
  end
end

class MyClass
  variable = 1
  @variable = 2
  @@variable = 3
end

# puts MyModule.variable
