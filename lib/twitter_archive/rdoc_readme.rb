require 'rdoc/markup/simple_markup'
require 'rdoc/markup/simple_markup/to_flow'
require 'rdoc/ri/ri_formatter'
require 'rdoc/ri/ri_options'

module TwitterArchive
  class RDocReadme
    def self.extract_sections(flow, sections)
      result = []
      sections.each do |name|
        name = name.downcase
        copy_upto_level = nil

        flow.each do |item|
          case item
          when SM::Flow::H
            if copy_upto_level && item.level >= copy_upto_level
              copy_upto_level = nil
            else
              if item.text.downcase == name
                result << item
                copy_upto_level = item.level
              end
            end
          else
            if copy_upto_level
              result << item
            end
          end
        end
      end
      if result.empty?
        puts "Note to developer: requested section(s) [#{sections.join(', ')}] " +
             "not found"
        result = flow
      end
      result
    end

    def self.rdoc_usage(*args)

      comment = File.open(File.dirname(__FILE__) + '/../../README.rdoc') {|f| f.read}

      markup = SM::SimpleMarkup.new
      flow_convertor = SM::ToFlow.new
      
      flow = markup.convert(comment, flow_convertor)

      format = "plain"

      unless args.empty?
        flow = extract_sections(flow, args)
      end

      options = RI::Options.instance
      if args = ENV["RI"]
        options.parse(args.split)
      end
      formatter = options.formatter.new(options, "")
      formatter.display_flow(flow)
    end
  end
end
