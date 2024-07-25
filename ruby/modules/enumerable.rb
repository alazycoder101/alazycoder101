class CustomSequence
  include Enumerable

  def initialize(numbers)
    @numbers = numbers
  end

  # Enumerable methods can be implemented if needed
  # For example, to make this class fully enumerable:
end

# Usage
numbers = CustomSequence.new(1..5)

numbers.each { |num| puts num }
