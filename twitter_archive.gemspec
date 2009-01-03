# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{twitter_archive}
  s.version = "0.0.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Christohper Sexton"]
  s.date = %q{2009-01-03}
  s.default_executable = %q{twitter_archive}
  s.description = %q{Twitter archive utility}
  s.email = %q{csexton@gmail.com}
  s.executables = ["twitter_archive"]
  s.extra_rdoc_files = ["bin/twitter_archive", "lib/twitter_archive/backends/blogger/base.rb", "lib/twitter_archive/backends/blogger/blogger.rb", "lib/twitter_archive/backends/blogger/post_body.html.erb", "lib/twitter_archive/backends/blogger/README", "lib/twitter_archive/backends/blogger_archive.rb", "lib/twitter_archive/backends/yaml_archive.rb", "lib/twitter_archive/base.rb", "lib/twitter_archive/rdoc_readme.rb", "lib/twitter_archive/runner.rb", "lib/twitter_archive/version.rb", "lib/twitter_archive.rb", "LICENSE", "README.rdoc", "tasks/rspec.rake"]
  s.files = ["bin/twitter_archive", "config/example.yml", "config/test.yml", "History", "lib/twitter_archive/backends/blogger/base.rb", "lib/twitter_archive/backends/blogger/blogger.rb", "lib/twitter_archive/backends/blogger/post_body.html.erb", "lib/twitter_archive/backends/blogger/README", "lib/twitter_archive/backends/blogger_archive.rb", "lib/twitter_archive/backends/yaml_archive.rb", "lib/twitter_archive/base.rb", "lib/twitter_archive/rdoc_readme.rb", "lib/twitter_archive/runner.rb", "lib/twitter_archive/version.rb", "lib/twitter_archive.rb", "LICENSE", "Manifest", "Rakefile", "README.rdoc", "script/console", "script/destroy", "script/generate", "spec/backends/blogger_archive_spec.rb", "spec/backends/yaml_archive_spec.rb", "spec/fixtures/blogger_authenticate_response.yml", "spec/fixtures/blogger_post_response.yml", "spec/fixtures/twitter_response.yml", "spec/spec.opts", "spec/spec_helper.rb", "spec/twitter_archive_spec.rb", "tasks/rspec.rake", "tmp/test_yaml_archive.yml", "twitter_archive.gemspec"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/csexton/twitter_archive}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Twitter_archive", "--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{twitter_archive}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Twitter archive utility}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<twitter>, [">= 0.4"])
      s.add_runtime_dependency(%q<hpricot>, [">= 0.6"])
      s.add_development_dependency(%q<echoe>, [">= 0"])
    else
      s.add_dependency(%q<twitter>, [">= 0.4"])
      s.add_dependency(%q<hpricot>, [">= 0.6"])
      s.add_dependency(%q<echoe>, [">= 0"])
    end
  else
    s.add_dependency(%q<twitter>, [">= 0.4"])
    s.add_dependency(%q<hpricot>, [">= 0.6"])
    s.add_dependency(%q<echoe>, [">= 0"])
  end
end
