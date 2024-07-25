trace = TracePoint.new(:end) do |tp|
  klass = tp.self
  if klass.is_a?(Class) || klass.is_a?(Module)
    puts "Methods added to #{klass}:"
    new_methods = klass.instance_methods(false)
    puts "  Instance methods: #{new_methods.join(', ')}"
    new_class_methods = klass.singleton_class.instance_methods(false) - Module.instance_methods
    puts "  Class methods: #{new_class_methods.join(', ')}"
  end
end

trace.enable

module Module1
  def module1_method; end
end

module Module2
  def module2_method; end
end

class MyClass
  include Module1
  extend Module2
end

trace.disable
