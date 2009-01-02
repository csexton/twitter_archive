#!/usr/bin/env ruby 

# == Synopsis 
#   Twitter Archive Utility
#
# == Usage 
#   twitter_archive [options]
#
#   For help see http://github.com/csexton/twitter_archive/
#
# == Options
#   -h, --help          Displays help message
#   -v, --version       Display the version, then exit
#   -V, --verbose       Verbose output
#   TO DO - add additional options

require 'optparse'
require 'rdoc/usage'

class Logger
  def format_message(severity, timestamp, progname, msg)
    "#{msg}\n"
  end
end

module TwitterArchive
  class Runner
    def self.runner
      ta = TwitterArchive::Base.new
      ta.load_config

      parse_options 

      puts ta.get_latest
      ta.save_config
    end

    def self.parse_options
      OptionParser.new do |opts|
        opts.summary_width = 25

        opts.banner = "twitter_archive (#{TwitterArchive::VERSION})\n\n",
                      "usage: twitter_archive \n",
                      "       twitter_archive --help\n",
                      "       twitter_archive --version\n"

        opts.separator ""

        opts.on('-v', '--version') do 
          puts "twitter_archive (#{TwitterArchive::VERSION})\n\n"
          exit
        end
        opts.on('-h', '--help') do
          puts "twitter_archive (#{TwitterArchive::VERSION})\n\n"
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
