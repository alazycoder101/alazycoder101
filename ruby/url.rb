require 'cgi'
CGI.parse('q=a%20b') # => {"q"=>["a b"]}
CGI.parse('q=a+b')   # => {"q"=>["a b"]}

