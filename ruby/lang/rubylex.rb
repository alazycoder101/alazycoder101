require 'strscan' # RubyLex is typically used with StringScanner
#require 'rubylex'

require 'irb'
source = "puts 'Hello, World!'"
binding.irb
# lexer = IRB::RubyLex.new(StringScanner.new(source))
lexer = IRB::RubyLex.new(source)

tokens = []
until lexer.eos?
  token = lexer.token
  tokens << token unless token.nil?
end

puts tokens.inspect
