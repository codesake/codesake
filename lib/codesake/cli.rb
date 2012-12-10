require 'optparse'
require 'trimmy'

module Codesake
  class Cli
    
    def parse(command_line)
      ret = {}

      return {} if (command_line.nil?) or (command_line.trim.empty?)

      begin
        opts=OptionParser.new
        opts.on("-h", "--help") do 
          ret[:help] = true 
        end

        opts.on("-v", "--version") do
          ret[:version] = true
        end

        opts.on("-V", "--verbose") do
          ret[:verbose] = true
        end

        opts.on("-o VAL", "--output", "Write output to file, to json string or to db usin SQLite3") do |val|
          ret[:output]=:screen
          val=val.trim
          ret[:output]=val.to_sym if (val.to_sym == :file) or (val.to_sym == :json) or (val.to_sym == :db)
        end


        rest = opts.parse(command_line)

        ret[:target] = [] 
        ret[:target] = build_target_list(rest[0].split(" ")) if expect_targets?(ret) and (! rest.empty?) and (! rest[0].nil?)
      rescue OptionParser::InvalidOption => e
        ret={:error=>true, :message=>e.message}
      end
      ret
    end


    def is_good_target?(target)
      (!Dir.glob(target).empty?) or File.exists?(target) or File.directory?(target)
    end

    private
    def expect_targets?(ret)
      (! ret[:help] ) and ( ! ret[:version]) 
    end

   
    def build_target_list(target_list)
      ret = []
      target_list.each do |target|
        ret << {:target=>target, :valid=>is_good_target?(target)} 
      end

      ret
    end

  end
end
