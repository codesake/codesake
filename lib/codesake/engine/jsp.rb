require 'codesake/engine/core'

module Codesake
  module Engine
    class Jsp
      include Codesake::Utils::Files
      include Codesake::Utils::Secrets
      include Codesake::Engine::Core

      FALSE_POSITIVES = ["request.getContextPath()", "request.getLocalName()", "request.getLocalPort()"]


      attr_reader :imports
      attr_reader :attack_entrypoints
      attr_reader :reflected_xss
      attr_reader :cookies

      def initialize(filename, options)
        @filename = filename
        @options = options

        read_file
        load_secrets
      end

      def analyse
        ret =  []
        @reserved_keywords  = find_reserved_keywords
        @imports            = find_imports
        @attack_entrypoints = find_attack_entrypoints
        @reflected_xss      = find_reflected_xss
        @cookies            = find_cookies

        @reserved_keywords.each do |secret|
          ret << "reserved keyword found: \"#{secret[:matcher]}\" (#{@filename}@#{secret[:line]})"
        end
        @imports.each do |import|
          ret << "imported package found: \"#{import[:package]}\""
        end

        @attack_entrypoints.each do |entry|
          ret << "attack entrypoint found: parameter \"#{entry[:param]}\" stored in \"#{entry[:var]}\" (#{@filename}@#{entry[:line]})"
        end
        @reflected_xss.each do |entry|
          ret << "suspicious reflected xss found: \"#{entry[:var]}\" (#{@filename}@#{entry[:line]})\"" if entry[:false_positive] and @options[:vulnerabilities] == :all
          ret << "reflected xss found: \"#{entry[:var]}\" (#{@filename}@#{entry[:line]})\"" if ! entry[:false_positive] 
        end

        @cookies.each do |c|
          ret << "cookie \"#{c[:name]}\" found with value: \"#{c[:value]}\" (#{@filename}@#{c[:line]})" 
        end

         
        ret
      end



      private
      # redefined
      def find_reserved_keywords

        ret = []

        @file_content.each_with_index do |l, i|
          l = l.unpack("C*").pack("U*")
          @secrets.each do |s|
            ret << {:line=> i+1, :matcher=>s } if l.trim.include?(s)
          end
        end

        ret
      end

      def find_cookies
        ret = []

        @file_content.each_with_index do |l, i|
          l = l.unpack("C*").pack("U*")
          m = /Cookie (.*?) = new Cookie \("(.*?)",(.*?)\)/.match(l);
          ret << {:line => i+1, :var => m[1].trim, :name => m[2].trim.gsub("\"", ""), :value => m[3].trim.gsub("\"", "")} unless m.nil?

          m = /Cookie (.*?) = new Cookie\("(.*?)",(.*?)\)/.match(l);
          ret << {:line => i+1, :var => m[1].trim, :name => m[2].trim.gsub("\"", ""), :value => m[3].trim.gsub("\"", "")} unless m.nil?


          m = /(.*?) = new Cookie \("(.*?)",(.*?)\)/.match(l);
          ret << {:line => i+1, :var => m[1].trim, :name => m[2].trim.gsub("\"", ""), :value => m[3].trim.gsub("\"", "")} unless m.nil?


        end
        ret
      end



      def find_reflected_xss
        ret = []
        @file_content.each_with_index do |l, i|
          # <%=avar%> #=> /<%=(\w+)%>/.match(a)[1] = avar
          l = l.unpack("C*").pack("U*")
          m = /<%=(.*?)%>/.match(l)
          ret << {:line => i+1, :var=> m[1].trim, :false_positive=>Codesake::Engine::Jsp.is_false_positive?(m[1].trim)} unless m.nil?

          m = /out\.println\((.*?)\)/.match(l)
          ret << {:line => i+1, :var=> m[1].trim, :false_positive=>Codesake::Engine::Jsp.is_false_positive?(m[1].trim)} unless m.nil?

          m = /out\.print\((.*?)\)/.match(l)
          ret << {:line => i+1, :var=> m[1].trim, :false_positive=>Codesake::Engine::Jsp.is_false_positive?(m[1].trim)} unless m.nil?

          m = /out\.write\((.*?)\)/.match(l)
          ret << {:line => i+1, :var=> m[1].trim, :false_positive=>Codesake::Engine::Jsp.is_false_positive?(m[1].trim)} unless m.nil?

          m = /out\.writeln\((.*?)\)/.match(l)
          ret << {:line => i+1, :var=> m[1].trim, :false_positive=>Codesake::Engine::Jsp.is_false_positive?(m[1].trim)} unless m.nil?
        end

        ret
      end

      def self.is_false_positive?(var)
        FALSE_POSITIVES.include?(var)
      end


      def find_attack_entrypoints
        ret = []
        @file_content.each_with_index do |l, i|
          l = l.unpack("C*").pack("U*")
          m = /request.getParameter\((.*?)\)/.match(l)
          ret << {:line => i+1, :param => m[1].trim.gsub("\"", ""), :var => variable_from_line(l) } unless m.nil?

          m = /request.getParameterValues\((.*?)\)/.match(l)
          ret << {:line => i+1, :param => m[1].trim.gsub("\"", ""), :var => variable_from_line(l) } unless m.nil?

          m = /request.getAttribute\((.*?)\)/.match(l)
          ret << {:line => i+1, :param => m[1].trim.gsub("\"", ""), :var => variable_from_line(l) } unless m.nil?

        end

        ret
      end
      def variable_from_line(line)
        ret = "" 
        left_operand = line.split('=')[0]
        l = left_operand.split
        l[l.size - 1]
      end



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
