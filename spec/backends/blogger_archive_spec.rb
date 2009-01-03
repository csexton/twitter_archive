require File.dirname(__FILE__) + '/../spec_helper.rb'
require File.dirname(__FILE__) + '/../../lib/twitter_archive/backends/blogger_archive.rb'

describe TwitterArchive::Backends::BloggerArchive do
  before(:all) do 
      puts " WARNING Not testing with live blogger, set TEST_BLOGGER to enable" unless ENV['TEST_BLOGGER']
  end

  before(:each) do
    @ba = TwitterArchive::Backends::BloggerArchive.new
    @twitter_response = YAML::load_file File.dirname(__FILE__) +'/../fixtures/twitter_response.yml'

    if(ENV['TEST_BLOGGER'])
      @config = YAML::load_file(ENV['HOME'] + '/.twitter_archive.yml')
      GData::Base.stub!(:authenticate).and_return(YAML::load_file(
        File.dirname(__FILE__) + '/../fixtures/blogger_authenticate_response.yml'))
    else
      @config = YAML::load_file(File.dirname(__FILE__) + '/../../config/test.yml')
    end

  end

  it "should create an instance" do
    @ba.should be_an_instance_of(TwitterArchive::Backends::BloggerArchive)
  end

  it "should test post to blogger" do
    GData::Base.stub!(:post).and_return(YAML::load_file(
      File.dirname(__FILE__) + '/../fixtures/blogger_authenticate_response.yml'))

    @config['blogger_title'] = "Testing twitter_archive"
    @ba.archive(@twitter_response['results'], @config)
  end

  it "should format html from the tweets" do
    body = @ba.format_post(@twitter_response['results'])

    body.should_not be_nil
  end

  it "should format time like google" do
    @ba.format_time("Sun, 28 Dec 2008 23:38:46 +0000").should eql "12/28/2008 at 11:38PM"
  end

  
end
