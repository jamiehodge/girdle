module Girdle
  class LogEntry
    
    def initialize(entry)
      @message = entry[:message] || entry['message']
      @time = entry[:time] || entry['time']
    end

    attr_reader :message, :time
  end
end