#$:.unshift(File.dirname(__FILE__)) unless
#  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'yaml'
require 'rubygems'
require 'twitter'

$:.unshift(File.dirname(__FILE__))
require 'twitter_archive/base'
require 'twitter_archive/runner'
require 'twitter_archive/version'

module TwitterArchive; end
