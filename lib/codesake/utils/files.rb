module Codesake
  module Utils
    module Files

      attr_accessor :filename
      attr_reader   :file_content

      def read_file
        @file_content = []
        @file_content = File.readlines(@filename) if File.exists?(@filename)
      end

      def lines
        @file_content.count
      end

      def lines_of_comment
        0
      end
      def loc
        0
      end
    end
  end
end
