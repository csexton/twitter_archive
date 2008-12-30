require File.dirname(__FILE__) + '/../spec_helper.rb'
require File.dirname(__FILE__) + '/../../lib/twitter_archive/backend/blogger_archive.rb'

describe TwitterArchive::Backend::BloggerArchive do
  before(:each) do
    @ya = TwitterArchive::Backend::BloggerArchive.new
  end

  it "should create an instance" do
    @ya.should be_an_instance_of(TwitterArchive::Backend::BloggerArchive)
  end

  
end
