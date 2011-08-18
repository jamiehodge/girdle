module Girdle
  
  class Grid
    
    attr_reader :id
    
    def initialize(id)
      @id = id
    end
    
    def self.list
      Girdle.run(grid: 'list')
    end
    
    def attributes
      Girdle.run(grid: 'attributes', gid: id)['gridAttributes']
    end
    
    def name
      attributes['name']
    end
    
    def megahertz
      attributes['gridMegahertz']
    end
    
    def is_default?
      attributes['isDefault'] == 'YES'
    end
    
  end
  
end