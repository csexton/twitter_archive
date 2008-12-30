require 'GData'
module TwitterArchive
  module Backend
    class BloggerArchive
      def archive(results, opts=nil)
        puts "Archiving to Blogger"
        results.each {|p| puts p['text']}

        blogger = GData::Blogger.new(opts['blogger_id'])
        blogger.authenticate(opts['blogger_user'], opts['blogger_pass'])

        puts blogger.entry('Testing from GData::Blogger', 'Now to clean things up')
      end
    end
  end
end

