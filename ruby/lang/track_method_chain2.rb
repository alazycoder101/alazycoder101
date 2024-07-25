module IncludeExtendTracker
  def included(base)
    puts "#{self} was included into #{base}"
    super
  end

  def extended(base)
    puts "#{self} was extended by #{base}"
    super
  end
end

Module.prepend(IncludeExtendTracker)

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