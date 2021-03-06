# lazy.rb
require_relative "./common"

number = ARGV.shift.to_i

print_usage_before_and_after do
  names = number.times.lazy
                .map { random_name }
                .map { |name| name.capitalize }
                .map { |name| "#{ name } Jr." }
                .select { |name| name[0] == "X" }
                .to_a
end