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
        ret[:target] = rest if (! ret[:help] ) and ( ! ret[:version]) and (! rest.empty?)
      rescue OptionParser::InvalidOption => e
        ret={:error=>true, :message=>e.message}
      end
      ret
    end

  end
end
