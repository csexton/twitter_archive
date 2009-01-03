require 'optparse'
require File.dirname(__FILE__) + '/rdoc_readme'

class Logger
  def format_message(severity, timestamp, progname, msg)
    "#{msg}\n"
  end
end

module TwitterArchive
  class Runner
    def self.runner
      @ta = TwitterArchive::Base.new

      parse_options 

      unless File.exists? @ta.config_file
        puts "Not config file found at '#{@ta.config_file}'"
        puts "See 'twitter_archive --help' for more details"
        exit
      end

      @ta.load_config

      puts @ta.get_latest
      @ta.save_config
    end

    def self.parse_options
      OptionParser.new do |opts|
        opts.summary_width = 25

        opts.on('-v', '--version') do 
          puts "twitter_archive (#{TwitterArchive::VERSION})\n\n"
          exit
        end
        opts.on('-h', '--help') do
          #RDoc::usage() #exits app 
          RDocReadme.rdoc_usage('usage', 'options')
          exit
        end
        opts.on('-V', '--verbose') do
          puts "Verbose!"
        end
        opts.on('-I', '--install') do
          puts "Installing example .twitter_archive.yml to your home directory"
          require "ftools"
          if File.exists? ENV['HOME'] + '/.twitter_archive.yml'
            puts " - #{ENV['HOME']}/.twitter_archive.yml already exists, skipping"
          else
            File.copy( File.dirname(__FILE__) + '/../../config/example.yml', ENV['HOME'] + '/.twitter_archive.yml')
          end
          exit
        end

      end.parse!
    end
  end
end
