require 'ripper'
class Parser < Ripper
  def initialize(...)
    super
    @comments = []
    @modules = {}
  end

  def on_comment(value) = @comments << [value[1..-1].strip, lineno]

  def on_const(value) = [value, lineno]
  def on_const_path_ref(left, right) = ["#{left[0]}::#{right[0]}", left[1]]
  def on_var_ref(value) = value

  def on_module(const, bodystmt)
    comments = []
    lineno = const[1]

    @comments.reverse_each do |comment|
      break if (lineno - comment[1]) > 1

      comments.unshift(comment[0])
      lineno = comment[1]
    end

    @modules[const[0]] = comments.join("\n")
  end

  def on_program(...) = @modules
end

p Parser.parse(<<~RUBY)
# This is the first module.
module Foo
end

# This is an unassociated comment.

# This is the second module.
# This is definitely the second module.
module Foo::Bar
end
RUBY
