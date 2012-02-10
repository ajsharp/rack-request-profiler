require 'spec_helper'

describe Rack::Profilers::Stathat do
  it "accepts callbacks" do
    EM.run {
      app = Rack::Builder.app do
        use Rack::Profilers::Stathat, :callback => lambda { |req| }

        run lambda { |env| [200, {'Content-Type' => 'text/plain'}, ['']]}
      end

      deferrable = mock("Deferrable")
      deferrable.expects(:callback).returns(EM.stop)
      EM::StatHat.any_instance.expects(:ez_value).returns(deferrable)

      Rack::MockRequest.new(app).get('/zomg/this/is/a/test')
    }
  end
end
