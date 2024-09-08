class Cookie
  def initialize(app, expiry)
    @app = app
    @expiry = expiry
  end

  def call(env)
    status, headers, body = @app.call(env)
    headers = headers.dup
    opts = {
        expires: Time.now + @expiry,
        value: 'value',
        path: '/',
    }
    Rack::Utils.set_cookie_header!(headers, "mycookie", opts)
    [ status, headers, body ]
  end
end