require File.dirname(__FILE__) + '/spec_helper.rb'

describe TwitterArchive::Base do
  before(:each) do
    @ta = TwitterArchive::Base.new
  end

  it "should score 0 for gutter game" do
    @ta.should_not be_nil
    puts @ta.inspect
  end
  
  it "should load the yaml file" do 
    @ta.config_file = File.dirname(__FILE__) + '/../config/test.yml'
    @ta.load_config
    @ta.config['backend'].should eql('yaml')
    @ta.config['accounts'][0]['name'].should eql('fuzzymonk')
  end
end
