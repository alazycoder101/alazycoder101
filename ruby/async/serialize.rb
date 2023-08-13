require 'debug'
require 'byebug'

def serialize_data(data)
  fiber = Fiber.new do
    # Simulate some serialization process
    serialized_data = data.to_s.reverse
    ##Fiber.yield serialized_data
  end

end

data_to_serialize = "Hello, world!"

serialized_data_fiber = serialize_data(data_to_serialize)
serialized_data_fiber.resume
puts "Serialization process started asynchronously..."

# Do some other work while serialization is happening
1.times do
  puts "Working on something else..."
  sleep 1
end

# Retrieve the serialized data when the Fiber is ready
byebug
serialized_data_filter.resume while serialized_data_fiber.resolved?
serialized_data = serialized_data_fiber
puts "Serialized data: #{serialized_data}"
