module Girdle
  module Helpers
    extend self
    
    def validate_options!(valid_options, options)
      options.each do |k,v|
        raise ArgumentError unless valid_options.include? k
      end
      true
    end
    
  end
end