require 'json'

# Sample JSON string
json_string = '{"name": "John", "age": 30, "address": {"street": "123 Main St", "city": "New York"}}'

# Parse the JSON string into a hash
parsed_hash = JSON.parse(json_string)

# Convert string keys to symbol keys
symbolized_hash = parsed_hash.transform_keys(&:to_sym)

# Now symbolized_hash has symbol keys
puts symbolized_hash
