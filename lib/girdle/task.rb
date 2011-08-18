module Girdle
  
  class Task

    attr_reader :name, :command, :arguments, :depends_on

    def initialize(options = {})
      @name       = options[:name]
      @command    = options[:command]
      @arguments  = options[:arguments]
      @depends_on = options[:depends_on]
    end

  end
  
end