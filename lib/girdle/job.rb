module Girdle

  class Job
    extend Girdle::Helpers

    attr_reader :name, :id

    def initialize(id)
      @id = id
    end

    def self.list(options = {})
      validate_options! [
        :gid,       # grid identifier
        ], options
        
      options.merge!(job: 'list')
      
      Girdle.run(options)['jobList']
    end

    def self.submit(cmd, options = {})
      validate_options! [
        :gid,       # grid identifier 
        :si,        # standard in
        :in,        # in directory
        :dids,      # job identifiers
        :email,     # notification email
        :art,       # art path
        :artid,     # art identifier
        :artequal,  # art value (equal)
        :artmin,    # art value (min)
        :artmax     # art value (max)
        ], options
        
      options.merge!(job: 'submit', cmd: cmd)
        
      Girdle.run(options)['jobIdentifier']
    end

    def self.run(cmd, options = {})
      validate_options! [
        :gid,       # grid identifier 
        :si,        # standard in
        :in,        # in directory
        :so,        # standard out
        :se,        # standard error
        :out,       # out directory
        :email,     # notification email
        :art,       # art path
        :artid,     # art identifier
        :artequal,  # art value (equal)
        :artmin,    # art value (min)
        :artmax     # art value (max)
        ], options
        
      options.merge!(job: 'run', cmd: cmd)
        
      Girdle.run(options)
    end

    def self.batch(spec, options = {})
      validate_options! [
        :gid,       # grid identifier
        ], options
        
      options.merge!(job: 'batch')
      
      if spec.respond_to?(:to_plist)
        plist = spec.to_plist
      else
        plist = spec
      end
        
      Girdle.run_batch(plist, options)['jobIdentifier']
    end

    def attributes
      Girdle.run(job: 'attributes', id: id)['jobAttributes']
    end
    
    def active_cpu_power
      attributes['activeCPUPower'].to_i
    end
    
    def date_now
      attributes['dateNow']
    end
    
    def date_started
      attributes['dateStarted']
    end
    
    def date_stopped
      attributes['dateStopped']
    end
    
    def date_submitted
      attributes['dateSubmitted']
    end
    
    def status
      attributes['jobStatus'].downcase.to_sym
    end
    
    def name
      attributes['name']
    end
    
    def percent_done
      attributes['percentDone']
    end
    
    def task_count
      attributes['taskCount'].to_i
    end
    
    def undone_task_count
      attributes['undoneTaskCount'].to_i
    end

    def results(options = {})
      self.class.validate_options! [
        :tid,       # task identifier
        :so,        # standard out
        :se,        # standard error
        :out        # out directory
        ], options
        
      options.merge!(job: 'results', id: id)
        
      Girdle.run(options)
    end

    def specification
      Girdle.run(job: 'specification', id: id)['jobSpecification']
    end

    def log
      Girdle.run(job: 'log', id: id)['jobLog']
    end
    
    def wait
      Girdle.run(job: 'wait', id: id)['jobStatus']
    end

    def stop
      Girdle.run(job: 'stop', id: id)
    end

    def suspend
      Girdle.run(job: 'suspend', id: id)
    end

    def resume
      Girdle.run(job: 'resume', id: id)
    end

    def delete
      Girdle.run(job: 'delete', id: id)
    end

    def restart
      Girdle.run(job: 'restart', id: id)
    end
  end
  
end