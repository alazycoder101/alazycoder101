require 'pry-remote'
require 'forwardable'
p Forwardable::VERSION

class Foo
  def initialize(x, y)
    binding.remote_pry
  end
end

Foo.new 10, 20
