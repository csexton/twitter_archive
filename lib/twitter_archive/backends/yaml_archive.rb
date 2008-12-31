module TwitterArchive
  module Backends
    class YamlArchive
      def archive(results, opts=nil)
        results.to_yaml
      end
    end
  end
end
