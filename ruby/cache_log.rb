module Readthis
  class LogSubscriber < ActiveSupport::LogSubscriber

    # LogSubscriber wraps payloads in an Event object, which has convenience
    # methods like `#duration`
    def cache_read(event)
      payload = event.payload

      debug "Readthis: #{payload[:name]} (#{event.duration}) #{payload[:key]}"
    end

    alias_method :cache_write, :cache_read
  end
end

Readthis::LogSubscriber.attach_to :active_support