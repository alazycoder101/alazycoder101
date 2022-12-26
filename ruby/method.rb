# https://www.alchemists.io/articles/ruby_method_parameters_and_arguments/
def show_params(func)
  f = method(func.to_sym)

  %i[arity parameters].each do |method|
    puts "#{method}: #{f.send(method)}"
  end
end

def check_params(name)
  puts '-' * 20
  puts name
  f = yield
  show_params(f)
end

check_params('no parameters') do
  def a
    puts 'a'
  end
end

check_params('default parameters') do
  def a(required_param, not_required_param=nil)
    puts "required_param=#{required_param}"
  end
end

check_params('named parameters') do
  def a(named:)
    puts "named: #{named}"
  end
end

check_params('leading parameters') do
  def a(required_param, not_required_param=nil); end
end


check_params(' parameters') do
  def a
    puts 'a'
  end
end

check_params('leading parameters') do
  def demo(...) = super
end

check_params(' parameters') do
  def demo(one, two = :b, *three, four:, five: :e, **six, &seven) = super
end

def hi(needed, needed2,
         maybe1 = "42", maybe2 = maybe1.upcase,
         *args,
         named1: 'hello', named2: a_method(named1, needed2),
         **options,
         &block)
  end
m = method(:a)
[:arity, :parameters, :owner, :receiver].each do |method|
  puts "#{method}: #{m.send(method)}"
end
