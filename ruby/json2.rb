require 'json'

def symbolize_keys(hash)
  hash.transform_keys { |key| key.to_sym }.transform_values do |value|
    if value.is_a?(Hash)
      symbolize_keys(value)
    elsif value.is_a?(Array)
      value.map { |item|
        item.is_a?(Hash) ? symbolize_keys(item) : item
      }
    else
      value
    end
  end
end

# Sample JSON string with nested hashes
json_string = '{"name": "John", "age": 30, "address": {"city": "New York", "zip": "10001"}, "hobbies": ["reading", {"name": "coding", "level": "advanced"}]}'

# Parse the JSON string into a hash
parsed_hash = JSON.parse(json_string)

# Convert all keys to symbol keys, including nested hashes
symbolized_hash = symbolize_keys(parsed_hash)

# Now symbolized_hash has symbol keys at all levels
puts symbolized_hash