module Girdle
  
  class Task

    attr_reader :name, :command, :arguments, :depends_on, :environment

    def initialize(options = {})
      @name         = options[:name]
      @command      = options[:command]
      @arguments    = options[:arguments]
      @depends_on   = 
        (options[:depends_on] || []).select {|d| d.kind_of? self.class }
      @environment  = options[:environment] || {}
    end
    
    def to_s
      @name
    end

  end
  
end