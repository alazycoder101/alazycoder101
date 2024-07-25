class MethodChainDebugger
  def self.track
    @original_include = Module.instance_method(:include)
    @original_extend = Module.instance_method(:extend)

    Module.define_method(:include) do |*modules|
      puts "Including #{modules} into #{self}"
      result = @original_include.bind(self).call(*modules)
      MethodChainDebugger.print_method_chain(self)
      result
    end

    Module.define_method(:extend) do |*modules|
      puts "Extending #{self} with #{modules}"
      result = @original_extend.bind(self).call(*modules)
      MethodChainDebugger.print_method_chain(self)
      result
    end
  end

  def self.print_method_chain(klass)
    puts "Method chain for #{klass}:"
    klass.ancestors.each { |ancestor| puts "  #{ancestor}" }
    puts "Singleton method chain for #{klass}:"
    klass.singleton_class.ancestors.each { |ancestor| puts "  #{ancestor}" }
    puts "\n"
  end
end

MethodChainDebugger.track

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