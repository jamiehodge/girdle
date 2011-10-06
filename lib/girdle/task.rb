module Girdle
  
  class Task

    attr_reader :name, :command, :arguments, :depends_on, :environment

    def initialize(options = {})
      @name         = options[:name]
      @command      = options[:command]
      @arguments    = (options[:arguments] || []).
        map {|a| a.respond_to?(:name) ? a.name : a }
      @depends_on   = (options[:depends_on] || []).
        map {|d| d.respond_to?(:name) ? d.name : d }
      @environment  = options[:environment] || {}
    end
  end
  
end