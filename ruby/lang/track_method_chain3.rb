class Module
  def self.track_methods
    class_eval do
      def method_added(method_name)
        puts "Instance method #{method_name} added to #{self}"
        super
      end

      def singleton_method_added(method_name)
        puts "Class method #{method_name} added to #{self}"
        super
      end
    end
  end
end

Module.track_methods

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