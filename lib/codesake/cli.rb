require 'optparse'
require 'trimmy'

module Codesake
  class Cli
    attr_reader :options
    attr_reader :targets
    
    def parse(command_line)
      @options = {}

      return {:vulnerabilities=>:all} if (command_line.nil?) or (command_line.send(:empty?))

      begin
        option_parser =OptionParser.new do |opts|
          executable_name = File.basename($PROGRAM_NAME)
          opts.banner = 
            "codesake v#{Codesake::VERSION} - (C) 2012 - paolo@armoredcode.com\nReviews one or more source file for security issues.\n\nUsage #{executable_name} [options] sources\n"
        # opts.on("-h", "--help") do 
        #   @options[:help] = true 
        # end

        opts.on("-v", "--version", "Show codesake version") do
          @options[:version] = true
        end

        opts.on("-V", "--verbose", "Be verbose") do
          @options[:verbose] = true
        end

        opts.on("-k KEYWORDS", "--add-keys", "Add the command separated list of strings as reserved keywords") do |val|
          @options[:keywords] = val.trim.split(",")
        end

        opts.on("-o TARGET", "--output", "Write output to file, to json string or to db usin SQLite3") do |val|
          @options[:output]=:screen
          val=val.trim
          @options[:output]=val.to_sym if (val.to_sym == :file) or (val.to_sym == :json) or (val.to_sym == :db)
        end
        opts.on("-C", "--confirmed-vulnerabilities", "Show only confirmed vulnerabilities") do
          @options[:vulnerabilities] = :confirmed
        end
        opts.on("-A", "--all-vulnerabilities", "Show all vulnerabilities found [default]") do
          @options[:vulnerabilities] = :all
        end

        end

        rest = option_parser.parse(command_line)

        @targets = [] 
        @targets = build_target_list(rest[0].split(" ")) if expect_targets? and (! rest.empty?) and (! rest[0].nil?)
        @options[:vulnerabilities] = :all if @options[:vulnerabilities].nil?
      rescue OptionParser::InvalidOption => e
        @options={:error=>true, :message=>e.message}
      end
      @options
    end


    def is_good_target?(target)
      (!Dir.glob(target).empty?) or File.exists?(target) or File.directory?(target)
    end

    def has_errors?
      (@options[:error])
    end

    def error_message
      @options[:message] if has_errors?
    end


    private
    def expect_targets?
      (! @options[:help] ) and ( ! @options[:version]) 
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
