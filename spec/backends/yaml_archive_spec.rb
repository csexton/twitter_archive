require File.dirname(__FILE__) + '/../spec_helper.rb'
require File.dirname(__FILE__) + '/../../lib/twitter_archive/backend/yaml_archive.rb'

describe TwitterArchive::Backend::YamlArchive do
  before(:each) do
    @ya = TwitterArchive::Backend::YamlArchive.new
  end

  it "should create an instance" do
    @ya.should be_an_instance_of(TwitterArchive::Backend::YamlArchive)
  end

  
end
