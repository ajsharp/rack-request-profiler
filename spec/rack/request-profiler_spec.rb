require 'spec_helper'

describe Rack::RequestProfiler do
  include Rack::Test::Methods

  it "implements the handle_results interface" do
    Rack::RequestProfiler.new(lambda {}).should respond_to :handle_results
  end

  it "invokes the handle_results interface" do
    class Rack::CustomProfiler < Rack::RequestProfiler
      def handle_results(env)
      end
    end
    app = Rack::Builder.app do
      use Rack::CustomProfiler

      run lambda { |env| [200, {'Content-Type' => 'text/plain'}, ['']]}
    end

    Rack::CustomProfiler.any_instance.should_receive(:handle_results)
    Rack::MockRequest.new(app).get('/')
  end

  it "does not invoke handle_results if ignore_path matches" do
    app = Rack::Builder.app do
      use Rack::RequestProfiler, :ignore_path => /ignore_me/

      run lambda { |env| [200, {'Content-Type' => 'text/plain'}, ['']]}
    end

    Rack::RequestProfiler.any_instance.should_not_receive(:handle_results)
    Rack::MockRequest.new(app).get('/ignore_me')
  end
end