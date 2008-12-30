Dir.glob(File.dirname(__FILE__)+ '/backend/*.rb').each {|f| require f }

module TwitterArchive

  class Base
    attr_accessor :config_file, :config

    def self.runner
      puts "Running Twitter Archiver"
      ta = TwitterArchive::Base.new
      ta.load_config
      ta.get_latest
      ta.save_config
    end

    def initialize(config_file = nil)
      @config_file = config_file || ENV['HOME'] + '/.twitter_archive.yml'
    end

    def get_latest
      @config['accounts'].each do |account|
        results = fetch_from_account(account['name'], account['last_max_id'] || 0)
        load_backend(config['backend']).archive(results['results'], config)
        config['last_max_id'] = results['max_id']
      end
    end

    def fetch_from_account(name, last_max_id=0)
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

    def load_backend(backend_name)
      eval "TwitterArchive::Backend::#{backend_name.capitalize}Archive.new"
    end
    
  end
end
