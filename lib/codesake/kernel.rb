require 'singleton'

module Codesake
  class Kernel
    include Singleton

    attr_reader   :engine

    NONE    = 0
    TEXT    = 1
    JSP     = 2
    UNKNOWN = -1

    def choose_engine(filename)


      engine = nil

      case detect(filename)
      when TEXT
        engine = Codesake::Engine::Text.new(filename)
      when NONE
        engine = Codesake::Engine::Generic.new(filename)
      when JSP
        engine = Codesake::Engine::Jsp.new(filename)
      end
      engine
    end

    def detect(filename)
      return NONE if filename.nil? or filename.empty?
      return TEXT if Codesake::Engine::Text.is_txt?(filename)
      return JSP if (File.extname(filename) == ".jsp")


      return UNKNOWN
    end
  end
end
