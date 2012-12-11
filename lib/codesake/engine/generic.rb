module Codesake
  module Engine
    class Generic
      include Codesake::Utils::Files

      def initialize(filename)
        @filename = filename
      end

    end
  end
end
