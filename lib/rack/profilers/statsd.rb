require 'rack/request-profiler'
require 'statsd'

module Rack
  module Profilers
    class Statsd < RequestProfiler

      # @example
      #   use Rack::Profilers::Statsd, Statsd.new('localhost'), :ignore_path => /^\/assets/
      #
      # @param [Statsd] statsd an instance of your statsd client
      # @param [Hash] opts a hash of options
      # @option :namespace namespce string for statsd
      # @option :ignore_path request paths to ignore and not handle
      def initialize(app, statsd, opts = {})
        @app, @statsd, @opts = app, statsd, opts
      end

      def handle_results(env, request)
        clean_url = Utils::UrlStripper.replace_id(request.path)
        clean_url = clean_url[1..-1].gsub('/', '.')
        namespace = @opts[:namespace] || ''

        @statsd.timing("#{namespace}#{request.request_method}.#{clean_url}", run_time)
      end
    end
  end
end
