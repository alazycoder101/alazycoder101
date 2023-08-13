class Echo
  include Concurrent::Async

  def echo(msg)
    print "#{msg}\n"
  end
end

horn = Echo.new
horn.echo('zero')      # synchronous, not thread-safe
                       # returns the actual return value of the method

horn.async.echo('one') # asynchronous, non-blocking, thread-safe
                       # returns an IVar in the :pending state

horn.await.echo('two') # synchronous, blocking, thread-safe
                       # returns an IVar in the :complete state
