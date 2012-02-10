$:.push(File.dirname(File.expand_path(__FILE__)))

require File.join(File.expand_path(File.dirname(__FILE__)), '..', 'lib', 'rack-request-profiler')

require 'rack/test'
require 'em-stathat'
require 'sinatra/base'

EventMachine::StatHat.config do |c|
  c.ukey  = 'key'
  c.email = 'user@example.com'
end

RSpec.configure do |config|
  config.mock_with :mocha
end
