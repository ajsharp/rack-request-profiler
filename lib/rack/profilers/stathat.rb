require 'rack/request-profiler'
require 'em-stathat'

module Rack
  module Profilers

    # NOTE: This middleware expects that you are running an EventMachine
    # reactor in the current process, and should not be used otherwise.
    class Stathat < RequestProfiler

      # @param [Hash] opts
      # @option [Proc] :errback errback passed to the eventmachine instance
      # @option [Proc] :callback callback passed to the eventmachine instance
      def initialize(app, opts = {})
        @app, @opts = app, opts
      end

      # @param [Hash] env the rack env
      # @param [Rack::Request] request a request object constructed
      #   from env
      def handle_results(env, request)
        clean_url = Utils::UrlStripper.replace_id(request.path)

        EM.next_tick do
          deferrable = EM::StatHat.new.ez_value("#{request.request_method} #{clean_url}", run_time)
          deferrable.callback(&@opts[:callback]) if @opts[:callback]
          deferrable.errback(&@opts[:errback]) if @opts[:errback]
        end
      end
    end
  end
end
