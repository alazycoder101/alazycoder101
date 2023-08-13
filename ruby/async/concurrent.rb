require('concurrent')

# Promise
future = Concurrent::Promises.future(2) do |duration|
  sleep duration
  :result
end
puts future.value

# Chaining
arg = 1
Thread.new(arg) { |arg| do_stuff arg }
Concurrent::Promises.future(arg) { |arg| do_stuff arg }

# Zipping
branch1.zip(branch2).value!
(branch1 & branch2).
    then { |a, b| a + b }.
    value!
(branch1 & branch2).
    then(&:+).
    value!
Concurrent::Promises.
    zip(branch1, branch2, branch1).
    then { |*values| values.reduce(&:+) }.
    value!
