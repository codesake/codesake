module Codesake
  module Engine
    class Text
      include Codesake::Utils::Files

      def initialize(filename)
        @filename = filename
      end

      def is_txt?
        (File.extname(filename) == ".txt")
      end

    end
  end
end
