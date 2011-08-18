require_relative '../spec_helper'

describe Girdle::Job do
  
  it 'must have an id attribute' do
    job = Girdle::Job.new(123)
    job.id.must_equal 123
  end
  
  describe 'new jobs' do
    it 'must submit asynchronous job and return an id' do
      Girdle.expects(:run).with(job: 'submit', cmd: '/bin/echo hello').
              returns('jobIdentifier' => '123')
      id = Girdle::Job.submit('/bin/echo hello')
      id.must_equal '123'
    end

    it 'must run and retrieve result synchronously' do
      Girdle.expects(:run).with(job: 'run', cmd: '/bin/echo hello').
              returns('hello')
      result = Girdle::Job.run('/bin/echo hello')
      result.must_equal 'hello'
    end

    it 'must submit batch file and return an id' do
      plist = Girdle::Specification.new(
        name: 'specification name',
        notification_email: 'email@example.com',
        tasks: [
          Girdle::Task.new(
            name: 'task name', 
            command: '/bin/echo', 
            arguments: ['hello'], 
            depends_on: ['another task']
          )
        ]
      ).to_plist
      Girdle.expects(:run_batch).
        with(plist, job: 'batch').
        returns('jobIdentifier' => '123')
      id = Girdle::Job.batch(plist)
      id.must_equal '123'
    end
  end
  
  it 'must retrieve list of jobs' do
    Girdle.expects(:run).with(job: 'list').returns('jobList' => %w{1 2 3})
    list = Girdle::Job.list
    list.must_equal %w{1 2 3}
  end
  
  describe 'a job' do
    
    before do
      @job = Girdle::Job.new(123)
    end
    
    describe 'attributes' do
      
      before do
        @attributes = {
          'activeCPUPower' => '0',
          'dateNow' => DateTime.parse('2011-08-18 11:20:43 +0000'),
          'dateStarted' => DateTime.parse('2011-07-15 10:05:18 +0000'),
          'dateStopped' => DateTime.parse('2011-07-15 10:07:46 +0000'),
          'dateSubmitted' => DateTime.parse('2011-07-15 10:02:53 +0000'),
          'jobStatus' => 'Finished',
          'name' => 'Untitled',
          'percentDone' => 100.0,
          'taskCount' => '13',
          'undoneTaskCount' => '1'
        }
      end
      
      it 'must retrieve attributes' do
        Girdle.expects(:run).
          with(job: 'attributes', id: 123).
          returns('jobAttributes' => @attributes)
        @job.attributes.must_equal @attributes
      end
      
      it 'must retrieve active cpu power' do
        @job.expects(:attributes).returns(@attributes)
        @job.active_cpu_power.must_equal 0
      end

      it 'must retrieve date now' do
        @job.expects(:attributes).returns(@attributes)
        @job.date_now.must_equal DateTime.parse('2011-08-18 11:20:43 +0000')
      end
      
      it 'must retrieve date started' do
        @job.expects(:attributes).returns(@attributes)
        @job.date_started.must_equal DateTime.parse('2011-07-15 10:05:18 +0000')
      end
      
      it 'must retrieve date stopped' do
        @job.expects(:attributes).returns(@attributes)
        @job.date_stopped.must_equal DateTime.parse('2011-07-15 10:07:46 +0000')
      end
      
      it 'must retrieve date submitted' do
        @job.expects(:attributes).returns(@attributes)
        @job.date_submitted.must_equal DateTime.parse('2011-07-15 10:02:53 +0000')
      end

      it 'must retrieve status' do
        @job.expects(:attributes).returns(@attributes)
        @job.status.must_equal :finished
      end
      
      it 'must retrieve name' do
        @job.expects(:attributes).returns(@attributes)
        @job.name.must_equal 'Untitled'
      end
      
      it 'must retrieve percent done' do
        @job.expects(:attributes).returns(@attributes)
        @job.percent_done.must_equal 100
      end
      
      it 'must retrieve task count' do
        @job.expects(:attributes).returns(@attributes)
        @job.task_count.must_equal 13
      end
      
      it 'must retrieve undone task count' do
        @job.expects(:attributes).returns(@attributes)
        @job.undone_task_count.must_equal 1
      end
    end
    
    it 'must retrieve results' do
      Girdle.expects(:run).with(job: 'results', id: 123).returns('results')
      @job.results.must_equal 'results'
    end

    it 'must retrieve specification' do
      Girdle.expects(:run).
        with(job: 'specification', id: 123).
        returns('jobSpecification' => Hash.new)
      @job.specification.must_equal Hash.new
    end

    it 'must retrieve log' do
      Girdle.expects(:run).with(job: 'log', id: 123).returns('log')
      @job.log.must_equal 'log'
    end
    
    describe 'status' do
      
      it 'must stop, but don\'t delete' do
        Girdle.expects(:run).with(job: 'stop', id: 123)
        @job.stop
      end

      it 'must suspend' do
        Girdle.expects(:run).with(job: 'suspend', id: 123)
        @job.suspend
      end

      it 'must resume' do
        Girdle.expects(:run).with(job: 'resume', id: 123)
        @job.resume
      end

      it 'must stop and delete' do
        Girdle.expects(:run).with(job: 'delete', id: 123)
        @job.delete
      end

      it 'must restart a running or stopped job' do
        Girdle.expects(:run).with(job: 'restart', id: 123)
        @job.restart
      end
    end
  end
end