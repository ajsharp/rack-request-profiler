require 'spec_helper'

describe Rack::RequestProfiler do
  include Rack::Test::Methods
  class MockApp < Sinatra::Base
    use Rack::RequestProfiler, :ignore_path => /ignore_me/
    get '/' do
      [200, "Hello, world"]
    end

    get '/ignore_me' do
      [200, "Ignore me"]
    end
  end

  def app
    @app ||= Rack::Builder.app do
      run MockApp
    end
  end

  it "implements the handle_results interface" do
    Rack::RequestProfiler.new(lambda {}).should respond_to :handle_results
  end

  it "invokes the handle_results interface" do
    Rack::RequestProfiler.any_instance.expects(:handle_results).once
    Rack::MockRequest.new(app).get('/')
  end

  it "does not invoke handle_results if ignore_path matches" do
    Rack::RequestProfiler.any_instance.expects(:handle_results).never
    Rack::MockRequest.new(app).get('/ignore_me')
  end

  it "does not invoke handlers if the status is 404" do
    Rack::RequestProfiler.any_instance.expects(:handle_results).never
    Rack::MockRequest.new(app).get('/does/not/exist')
  end
end
