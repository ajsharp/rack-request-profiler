module Rack
  autoload :RequestProfiler, 'rack/request-profiler'

  module Profilers
    autoload :Statsd,  'rack/profilers/statsd'
    autoload :Stathat, 'rack/profilers/stathat'
  end

  module Utils
    autoload :UrlStripper, 'rack/utils/url_stripper'
  end
end
