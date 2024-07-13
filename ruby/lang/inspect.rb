require 'irb'

class User
  def self.count
    10
  end

  def self.find
    self.new('user')
  end

  def initialize(name = '')
    @name = name
  end

  def name
    @name
  end

  def name=(name)
    @name = name
  end
end

k = User
u = User.new

show_source User
show_source User.find
show_source User#name

