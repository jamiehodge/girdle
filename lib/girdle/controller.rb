module Girdle
  
  class Controller
    
    attr_reader :id
    
    def initialize(id)
      @id = id
    end
    
    def self.list
      Girdle.run(controller: 'list')['controllerList']
    end
    
    def self.role
      Girdle.run(controller: 'role')['controllerRole']
    end
    
    def self.promote(role)
      Girdle.run(
        controller: 'promote', role: role.to_s.upcase
      )['controllerRole']
    end
    
    def self.autopromote(role)
      Girdle.run(
        controller: 'autopromote', role: role.to_s.upcase
      )['controllerRole']
    end
  end
  
end