require 'spec_helper'

describe Rack::Profilers::Statsd do
  include Rack::Test::Methods

  class MockApp < Sinatra::Base
    use Rack::Profilers::Statsd, Statsd.new('localhost')
    post '/posts/:id/update' do
      [200, "post content"]
    end
  end

  def app; @app ||= Rack::Builder.app { run MockApp }; end

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

  it "subs out ids" do
    Statsd.any_instance.expects(:timing).with("POST.posts.1.update", any_parameters)
    Rack::MockRequest.new(app).post('/posts/1/update')
  end
end
