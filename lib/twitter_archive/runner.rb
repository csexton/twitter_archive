module TwitterArchive
  class Runner
    def self.runner
      puts "Running Twitter Archiver"

      ta = TwitterArchive::Base.new
      puts ta.load_config
      puts ta.get_latest
      ta.save_config
    end
  end
end
