require 'set'
def func(*args)
  arg = args.first
  puts arg.object_id
  case arg
  when String
    arg.gsub!('a', '')
  when Array
    arg.push('2')
  when Hash
    arg[:extra] = 'a'
  when Set
    arg.add(3)
  end
  arg
end

def check_param(*args)
  param = args.first
  puts '-' * 10
  puts "before func: params=#{param}:#{param.class} object_id = #{param.object_id}"
  func(param)
  puts "after func: params=#{param}:#{param.class} object_id = #{param.object_id}"
end

check_param 1
check_param 'aabbb'
check_param :a
check_param [1, 2]
check_param({a: 'a', b: 'b'})
check_param(Set[1, 2])
