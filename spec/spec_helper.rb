$:.push(File.dirname(File.expand_path(__FILE__)))

require File.join(File.expand_path(File.dirname(__FILE__)), '..', 'lib', 'rack-request_profiler')

require 'rack/test'

RSpec.configure do |config|
end
