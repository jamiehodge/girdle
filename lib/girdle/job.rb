module Girdle

  class Job

    attr_reader :name, :id

    def initialize(id)
      @id = id
    end

    def self.list
      Girdle.run(job: 'list')['jobList']
    end

    def self.submit(cmd)
      Girdle.run(job: 'submit', cmd: cmd)['jobIdentifier']
    end

    def self.run(cmd)
      Girdle.run(job: 'run', cmd: cmd)
    end

    def self.batch(xml)
      Girdle.run_batch(xml, job: 'batch')['jobIdentifier']
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

    def results
      Girdle.run(job: 'results', id: id)
    end

    def specification
      Girdle.run(job: 'specification', id: id)['jobSpecification']
    end

    def log
      Girdle.run(job: 'log', id: id)['jobLog']
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