require 'erb'
require File.dirname(__FILE__) + '/blogger/blogger'

module TwitterArchive
  module Backends
    class BloggerArchive
      def archive(twitter_results, opts=nil)
        if twitter_results.length > 0
          blogger = GData::Blogger.new(opts['blogger_id'])
          blogger.authenticate(opts['blogger_user'], opts['blogger_pass'])

          res = blogger.entry(opts['blogger_title'] || 'Twitter', 
                        format_post(twitter_results),
                        {:labels => ['twitter'], :draft => true})

          if res.code == '201' # 201 - Created
            "Posting to blogger id #{opts['blogger_id']}, user #{opts['blogger_user']}"
          else
            "Error posting to blogger id #{opts['blogger_id']}, user #{opts['blogger_user']}: #{res.body}"
          end

        else
          "Nothing to post to blogger"
        end
      end

      def format_post(results)
        results 
        template = ERB.new(File.open(File.dirname(__FILE__) + '/blogger/post_body.html.erb') {|f| f.read})
        template.result(binding)
      end

      def format_time (date_str)
        time = Time.gm(*ParseDate.parsedate(date_str)[0..4])
        time.strftime("%m/%d/%Y at %I:%M%p")
      end
    end
  end
end

