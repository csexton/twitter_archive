module TwitterArchive
  module Backend
    class YamlArchive
      def archive(results, opts=nil)
        puts "Archiving to YAML"
        results.each {|p| puts p['text']}
      end
    end
  end
end
