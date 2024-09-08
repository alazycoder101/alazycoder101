require 'rack'

class Router
  def initialize(app)
    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)
    path = request.path

    case path
    when '/'
      @app.home.call(env)
    when '/hello/:name'
      @app.greet.call(env)
    when '/json'
      @app.json.call(env)
    else
      [404, {'Content-Type' => 'text/plain'}, ['Not Found']]
    end
  end
end

class Controller
  def self.home
    proc { [200, {'Content-Type' => 'text/plain'}, ['Hello, Rack!']] }
  end

  def self.greet
    proc { |env|
      name = Rack::Request.new(env).params['name']
      [200, {'Content-Type' => 'text/plain'}, ["Hello, #{name}!"]]
    }
  end

  def self.json
    proc { [200, {'Content-Type' => 'application/json'}, [{ message: 'This is a JSON response' }.to_json]]}
  end
end

# Create the Rack application
app = Proc.new do |env|
  router = Router.new(Controller)
  router.call(env)
end

# Run the Rack application
Rack::Server.start(app: app, Port: 9292)
