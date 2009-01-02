ProjectName = 'twitter_archive'
 
require 'rubygems'
require 'rake'
require 'echoe'
require 'spec/rake/spectask'
require "lib/#{ProjectName}/version"
 
Echoe.new(ProjectName, TwitterArchive::VERSION) do |p|
  p.description     = "Twitter archive utility"
  p.url             = "http://github.com/csexton/twitter_archive"
  p.author          = "Christohper Sexton"
  p.email           = "csexton@gmail.com"
  p.extra_deps      = [['twitter', '>= 0.4'], ['hpricot', '>= 0.6']]
  p.need_tar_gz     = false
  p.docs_host       = "http://github.com/csexton/twitter_archive/wikis"
end
 
desc 'Preps the gem for a new release'
task :prepare do
  %w[manifest build_gemspec].each do |task|
    Rake::Task[task].invoke
  end
end
 
Dir['tasks/**/*.rake'].each { |t| load t }

Rake::Task[:default].prerequisites.clear
task :default => :spec

