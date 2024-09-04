def test_raise
  raise "error"
end

def test_fail
  fail "error"
end

f = method(:fail)
r = method(:raise)
puts "fail == raise: #{f == r}"

test_raise
test_fail
