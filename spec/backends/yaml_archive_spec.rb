require File.dirname(__FILE__) + '/../spec_helper.rb'
require File.dirname(__FILE__) + '/../../lib/twitter_archive/backends/yaml_archive.rb'

describe TwitterArchive::Backends::YamlArchive do
  before(:each) do
    @ya = TwitterArchive::Backends::YamlArchive.new
  end

  it "should create an instance" do
    @ya.should be_an_instance_of(TwitterArchive::Backends::YamlArchive)
  end
  
end
