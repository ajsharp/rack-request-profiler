require 'spec_helper'

describe Rack::Utils::UrlStripper do
  describe '.replace_id' do
    it 'replaces BSON-like ids with ID' do
      ids = %w(5005536b28330e5a8800005f 4f07931e3641417a88000002)
      ids.each do |id|
        Rack::Utils::UrlStripper.replace_id("/resource/#{id}").should == '/resource/ID'
      end
    end

    it "replaces ids with sub-resources" do
      Rack::Utils::UrlStripper.replace_id("/resource/4f07931e3641417a88000002/another").should == '/resource/ID/another'
    end
  end
end
