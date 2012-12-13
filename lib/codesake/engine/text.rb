module Codesake
  module Engine
    class Text
      include Codesake::Utils::Files
      include Codesake::Utils::Secrets

      def initialize(filename)
        @filename = filename
        
        read_file
        load_secrets
      end

      def analyse
        ret =  []
        secrets = scan
        secrets.each do |secret|
          ret << "reserved keyword found: \"#{secret[:matcher]}\" (#{@filename}@#{secret[:line]})"
        end
         
        ret
        

      end

      def self.is_txt?(filename)

        (File.extname(filename).empty? or File.extname(filename) == ".txt" or File.extname(filename) == ".conf" or File.extname(filename) == ".rc" or File.extname(filename) == ".bak" or File.extname(filename) == ".old" )
      end

    end
  end
end
