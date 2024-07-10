require 'ripper'

code = <<-RUBY
  def hello
    puts "Hello, World!"
  end
RUBY

p Ripper.sexp_raw("1 + 2")
Ripper.parse('1 + 2')
Ripper.sexp(code) do |line, sexp|
  puts "#{line}: #{sexp.inspect}"
end

class Parser < Ripper
  def on_int(value)
    puts "Got an integer: #{value}"
  end
end

Parser.new("1 + 2").parse

class Parser < Ripper
  def on_binary(left, operator, right) = [:binary, left, operator, right]
  def on_int(value) = value.to_i
  def on_program(stmts) = stmts
  def on_stmts_add(stmts, stmt) = stmts << stmt
  def on_stmts_new = []
end

Parser.parse("1 + 2") # => [[:binary, 1, :+, 2]]

Ripper.sexp_raw(<<~RUBY)
module Foo::Bar
end
RUBY
