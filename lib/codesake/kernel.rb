require 'singleton'

module Codesake
  class Kernel
    include Singleton

    NONE    = 0
    TEXT    = 1
    JSP     = 2
    UNKNOWN = -1

    def choose_engine

    end

    def detect(filename)
      return NONE if filename.nil? or filename.empty?
      return TEXT if (File.extname(filename).empty? or File.extname(filename) == ".txt")
      return JSP if (File.extname(filename) == ".jsp")


      return UNKNOWN
    end
  end
end
