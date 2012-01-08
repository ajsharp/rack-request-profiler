require 'spec_helper'

describe Rack::Profilers::Statsd do
  include Rack::Test::Methods
  $statsd = Statsd.new 'localhost'

  it "sends stuff to statsd" do
    app = Rack::Builder.app do
      use Rack::Profilers::Statsd, $statsd
      run lambda { |env| [200, {}, ['']]}
    end

    obj = mock("object", :timing => true)
    $statsd.should_receive(:timing)
    response = Rack::MockRequest.new(app).get('/')
  end

  it "does not send stuff for ignored paths" do
    app = Rack::Builder.app do
      use Rack::Profilers::Statsd, $statsd, :ignore_path => /ignore-me/
      run lambda { |env| [200, {}, ['']]}
    end

    $statsd.should_not_receive(:timing)
    Rack::MockRequest.new(app).get('/ignore-me')
  end
end
