# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rack/request-profiler/version"

Gem::Specification.new do |s|
  s.name        = "rack-request-profiler"
  s.version     = Rack::RequestProfiler::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Alex Sharp"]
  s.email       = ["ajsharp@gmail.com"]
  s.homepage    = "https://github.com/ajsharp/rack-request-profiler"
  s.summary     = %q{Rack middleware for profiling request / response cycles.}
  s.description = %q{Provides a framework for sending wall time statistics to external services, such as statsd, stathat, etc.}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
