module TwitterArchive
  module Backends
    class YamlArchive
      # Archive the twitter results in a yaml file.
      # This requires opts to have 'yaml_file' set to the location to write the archive.
      def archive(results, opts=nil)

         opts['yaml_file'] ||= File.dirname(__FILE__) + '/../../../tmp/test_yaml_archive.yml'

        # sort in chronological order
        results.sort! {|a, b| a['created_at'] <=> b['created_at'] }

        # This will print the '---' yaml header between each set of results, which will prevent
        # yaml from parsing anything but the first set.  But this backend is currently only being 
        # used for testing so I am not going to worry about it right now.

        File.open(opts['yaml_file'], 'a+') do |out|
          YAML.dump(results, out)
        end
      end
    end
  end
end
