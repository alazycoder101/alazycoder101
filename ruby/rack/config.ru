class Hello
  def call(env)
    [200, {"Content-Type" => "text/html"}, ["Hello there!"]]
  end
end

run Hello.new