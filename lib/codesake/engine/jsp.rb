require 'codesake/engine/core'

module Codesake
  module Engine
    class Jsp
      include Codesake::Utils::Files
      include Codesake::Utils::Secrets
      include Codesake::Engine::Core

      attr_reader :imports

      def initialize(filename)
        @filename = filename

        read_file
        load_secrets
      end

      def analyse
        ret =  []
        @reserved_keywords  = find_reserved_keywords
        @imports            = find_imports

        @reserved_keywords.each do |secret|
          ret << "reserved keyword found: \"#{secret[:matcher]}\" (#{@filename}@#{secret[:line]})"
        end
         
        ret
      end


      private

      def find_imports
        ret = []
        @file_content.each_with_index do |l, i|
          l = l.unpack("C*").pack("U*")
          m = /<%@page import="(.*?)"%>/.match(l)
          ret << {:line => i+1, :package=>m[1].trim} unless m.nil?
        end

        ret
      end

    end
  end
end
