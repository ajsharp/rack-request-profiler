require 'spec_helper'

describe Rack::Utils::UrlStripper do
  describe '.replace_id' do
    it 'replaces BSON-like ids with ID' do
      Rack::Utils::UrlStripper.replace_id("/resource/4f07931e3641417a88000002").should == '/resource/ID'
    end

    it "replaces ids with sub-resources" do
      Rack::Utils::UrlStripper.replace_id("/resource/4f07931e3641417a88000002/another").should == '/resource/ID/another'
    end
  end
end
