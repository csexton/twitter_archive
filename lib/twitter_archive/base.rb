require 'parsedate'
Dir.glob(File.dirname(__FILE__)+ '/backends/*.rb').each {|f| require f }

module TwitterArchive

  class Base
    attr_accessor :config_file, :config

    def initialize(config_file = nil)
      @config_file = config_file || ENV['HOME'] + '/.twitter_archive.yml'
    end

    def get_latest
      all_results = []
      last_max_id = 0
      @config['accounts'].each do |account|
        twitter_response = fetch_from_account(account['name'], config['last_max_id'] || 0)
        config['current_twitter_account'] = account['name']
        puts "Collected #{twitter_response['results'].length} tweets from #{account['name']}"

        all_results = all_results + twitter_response['results']
        last_max_id =  twitter_response['max_id']
      end

      config['last_max_id'] = last_max_id

      all_results.sort! {|a, b| a['created_at'] <=> b['created_at'] }

      backend = load_backend(config['backend'])
      backend.archive(all_results, config)
    end

    def fetch_from_account(name, last_max_id=0)
      puts "last_max_id #{last_max_id}" 
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
      eval "TwitterArchive::Backends::#{backend_name.capitalize}Archive.new"
    end
    
  end
end
