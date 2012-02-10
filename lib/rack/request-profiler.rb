module Rack
  class RequestProfiler

    # @param [Hash] opts a hash of options
    # @option [Symbol] :ignore_path Request paths to ignore and not handle
    def initialize(app, opts = {})
      @app, @opts = app, opts
    end

    def start_time=(time)
      @start_time = time
    end

    def start_time
      @start_time
    end

    def call(env, &block)
      self.start_time = Time.now
      request         = Request.new(env)

      # Short-circuit here and pass the response back through the
      # middleware chain if the request path matches the ignore_path
      if @opts[:ignore_path] && request.path.match(@opts[:ignore_path])
        return @app.call(env)
      end

      status, headers, body = @app.call(env)

      unless status == 404
        handle_results(env, request)
      end
      [status, headers, body]
    end

    # Override this method in subclasses
    def handle_results(env, request = nil)
      # override me!
    end

    # Returns elapsed time since start_time in milliseconds.
    def run_time
      ((Time.now - start_time) * 1000).round
    end
  end
end
