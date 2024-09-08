require 'rack'

# Define a simple controller class
class SimpleController
  def self.index
    [200, {'Content-Type' => 'text/plain'}, ['Hello, Rack!']]
  end

  def self.show(name)
    [200, {'Content-Type' => 'text/plain'}, ["Hello, #{name}!"]]
  end

  def self.json
    [200, {'Content-Type' => 'application/json'}, [{ message: 'This is a JSON response' }.to_json]]
  end
end

# Define the router
class SimpleRouter
  def initialize(app)
    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)
    case request.path
    when '/'
      self.class.handle(SimpleController.method(:index))
    when '/hello/:name'
      name = request.params['name']
      self.class.handle(SimpleController.method(:show), name)
    when '/json'
      self.class.handle(SimpleController.method(:json))
    else
      [404, {'Content-Type' => 'text/plain'}, ['Not Found']]
    end
  end

  def self.handle(method, *args)
    response = method.call(*args)
    [response[0], response[1], [response[2].join]]
  end
end

# Create the Rack application
app = SimpleRouter.new(nil)

# Run the Rack application using WEBrick
Rack::Handler::WEBrick.run(app, Port: 9292)