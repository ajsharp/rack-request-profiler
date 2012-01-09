require 'spec_helper'

describe Rack::Profilers::Stathat do
  it "accepts callbacks" do
    EM.run {
      app = Rack::Builder.app do
        use Rack::Profilers::Stathat, :callback => lambda { |req| puts("hey"); EM.stop }

        run lambda { |env| [200, {'Content-Type' => 'text/plain'}, ['']]}
      end
      req = Rack::MockRequest.new(app).get('/')
    }
  end
end
