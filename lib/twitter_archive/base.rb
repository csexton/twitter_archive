module TwitterArchive

  class Base
    attr_accessor :config_file, :config

    def self.runner
      puts "Running Twitter Archiver"
      TwitterArchive::Base.new.get_latest
    end

    def initialize(config_file = nil)
      @config_file = config_file || ENV['HOME'] + '/.twitter_archive.yml'
    end

    def get_latest
      load_config

      @config['accounts'].each do |account|
        results = latest_from_account(account['name'], account['last_max_id'] || 0)
        process_results(@config['backend'], results['results'])
        puts "@@@@@@ #{results['max_id']}"
        account['last_max_id'] = results['max_id']
      end

      save_config
    end

    def latest_from_account(name, last_max_id=0)
      Twitter::Search.new.from(name).since(last_max_id).fetch
    end

    def load_config
      @config = YAML::load_file(@config_file)
    end

    def save_config
      File.open(@config_file, 'w') do |out|
        YAML.dump(config, out)
      end
    end

    def process_results(backend, results)
      if(load File.dirname(__FILE__) + "/backend/yaml_archive.rb")
        TwitterArchive::Backend::YamlArchive.archive(results)
      else
        raise "Unable to load backend"
      end
    end

    
  end
end
