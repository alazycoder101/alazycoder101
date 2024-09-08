require 'debug'
class Hello
  def call(env)
    debugger
    [200, {"content-type" => "text/html"}, ["Hello there!"]]
  end
end

run Hello.new
