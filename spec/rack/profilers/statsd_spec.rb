require 'spec_helper'

describe Rack::Profilers::Statsd do
  include Rack::Test::Methods

  it "sends stuff to statsd" do
    statsd = Statsd.new 'localhost'
    app = Rack::Builder.app do
      use Rack::Profilers::Statsd, statsd
      run lambda { |env| [200, {}, ['']]}
    end

    statsd.expects(:timing)
    response = Rack::MockRequest.new(app).get('/')
  end

  it "does not send stuff for ignored paths" do
    statsd = Statsd.new 'localhost'
    app = Rack::Builder.app do
      use Rack::Profilers::Statsd, statsd, :ignore_path => /ignore-me/
      run lambda { |env| [200, {}, ['']]}
    end

    statsd.expects(:timing).never
    Rack::MockRequest.new(app).get('/ignore-me')
  end

  it "prepends the namespace if passed in" do
    statsd = Statsd.new 'localhost'
    app = Rack::Builder.app do
      use Rack::Profilers::Statsd, statsd, :namespace => 'namespace.me.'
      run lambda { |env| [200, {}, ['']]}
    end

    Rack::Profilers::Statsd.any_instance.stubs(:run_time => 200)
    statsd.expects(:timing).with('namespace.me.GET.', 200)
    Rack::MockRequest.new(app).get('/')
  end
end
