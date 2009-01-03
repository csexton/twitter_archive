require File.dirname(__FILE__) + '/base'
require 'builder'

module GData

  class Blogger < GData::Base

    def initialize(blog_id, entry_id=nil)
      @blog_id = blog_id
      @entry_id = entry_id
      super 'blogger', 'gdata-ruby', 'www.blogger.com'
    end

    def feed
      request "/feeds/#{@blog_id}/posts/default"
    end

    def list_blogs(profile_id)
      request "/feeds/#{profile_id}/blogs"
    end

    def entry
      @entry ||= Hpricot(request("/feeds/#{@blog_id}/posts/default/#{@entry_id}"))
    end

    def enclosure
      entry.search('//link[@rel="enclosure"]')
    end

    def enclosure?
      enclosure.any?
    end
  
    def add_enclosure(enclosure_url, enclosure_length)
      raise "An enclosure has already been added to this entry" if enclosure?
      # todo(stevejenson): replace with builder
      entry.search('//entry').append(%Q{<link rel="enclosure" type="audio/mpeg" title="MP3" href="#{enclosure_url}" length="#{enclosure_length}" />})
      save_entry
    end

    def remove_enclosure
      if enclosure?
        enclosure.remove
        save_entry
      end
    end

    def save_entry
      path = "/feeds/#{@blog_id}/posts/default/#{@entry_id}"
  
      put(path, entry.to_s)
    end

    # Creates a new entry with the given title and body
    def entry(title, body, labels=[])
      x = Builder::XmlMarkup.new :indent => 2
      @entry = x.entry 'xmlns' => 'http://www.w3.org/2005/Atom' do
        x.title title, 'type' => 'text'
        x.content 'type' => 'xhtml' do
          x.div 'xmlns' => 'http://www.w3.org/1999/xhtml' do
            x << body
          end
        end
        labels.each do |label|
          x.category 'scheme' => "http://www.blogger.com/atom/ns#", 'term' => label
        end
      end
      
      path = "/feeds/#{@blog_id}/posts/default"
      post(path, @entry)
    end

  end

end
