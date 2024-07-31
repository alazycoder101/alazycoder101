# Require the 'ractor' library, which is available in Ruby 3.0 and later
#require 'ractor'

# Define a simple method to be run in a Ractor
def compute_square(number)
  number * number
end

# Create an array of numbers to be processed
numbers = [1, 2, 3, 4, 5]

# Create Ractors for each number in the array
ractors = numbers.map do |number|
  Ractor.new(number) do |n|
    compute_square(n)
  end
end

# Wait for all Ractors to finish and collect their results
results = ractors.map(&:take)

# Print the results
puts "Squares computed by Ractors: #{results}"
