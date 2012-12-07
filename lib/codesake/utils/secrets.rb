module Codesake
  module Utils
    module Secrets
      DEFAULT_SECRETS = ["secret", "password", "username", "login", "xxx", "fixme", "fix", "todo", "passwd"]
      attr_accessor :secrets

      def initialize
        @secrets = DEFAULT_SECRETS
      end

      def add(word)
        @secrets << word
        @secrets
      end

      def reserved?(word)
        @secrets.include?(word)
      end

      def scan

        ret = []

        self.file_content.each_with_index do |l, i|
          l = l.unpack("C*").pack("U*")
          l.split.each do |tok|
            ret << {:line=> i+1, :matcher=>tok, :source_line=>l} if @secrets.include?(tok.downcase)
          end
        end

        ret
      end



    end
  end
end
