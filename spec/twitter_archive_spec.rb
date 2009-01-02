require File.dirname(__FILE__) + '/spec_helper.rb'

describe TwitterArchive::Base do
  before(:each) do
    @ta = TwitterArchive::Base.new
    @ta.stub!(:fetch_from_account).and_return(YAML::load_file(
      File.dirname(__FILE__) + '/fixtures/twitter_response.yml'))
    @ta.stub!(:save_config).and_return(true)
    @ta.config_file = File.dirname(__FILE__) + '/../config/test.yml'
    # TODO stub out backend
  end

  it "should create an instance" do
    @ta.should be_an_instance_of(TwitterArchive::Base)
  end
  
  it "should load the yaml file" do 
    @ta.load_config
    @ta.config['backend'].should eql('yaml')
    @ta.config['accounts'][0]['name'].should eql('fuzzymonk')
  end

  it "should stub the fetch method" do
    @ta.fetch_from_account['max_id'].should eql(1083275701)
  end

  it "should stub the save_config" do 
    @ta.load_config
    @ta.config['joe'] = "test"
    @ta.save_config

    @ta.load_config
    @ta.config['joe'].should be_nil
  end

  it "should update the last_max_id in the config file" do
    @ta.load_config
    @ta.get_latest
    @ta.config['last_max_id'].should_not eql(@ta.load_config['last_max_id'])
  end

  it "should load the yaml backend dynamically" do
    @ta.load_backend('yaml').should be_an_instance_of TwitterArchive::Backends::YamlArchive
  end

  it "should raise an error when loading an invalid backend" do
   lambda do 
     @ta.load_backend('poopie')
     @processor.process(StringIO.new("z"*31))
   end.should raise_error(NameError)
    
  end
end
