module TwitterArchive
  module Backend
    class YamlArchive
      def self.archive(results)
        puts "Archiving to YAML"
        results.each {|p| puts p['text']}
      end
    end
  end
end
