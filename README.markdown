Girdle
=======

A client for submitting and managing Xgrid jobs.

Installation
------------

    gem install girdle
    
Usage
-----

Create a job specification:

    spec = Girdle::Specification.new(name: 'example_spec', notification_email: 'admin@example.com')
    
Add a task:

    spec.tasks << Girdle::Task.new(name: 'hello', command: '/usr/bin/say', 
                                   arguments: ['hello'])
    
Add another, this one dependent on the first:

    spec.tasks << Girdle::Task.new(name: 'world', command: '/usr/bin/say', 
                                   arguments: ['world'], depends_on: ['hello'])
    
Submit the specification and return an id:

    job_id = Girdle::Job.batch(spec.to_plist)
    
Create a new job using the returned id:

    job = Girdle::Job.new(job_id)
    
Check its status:

    job.status
    
Control its state:

    job.suspend
    job.resume
    job.restart
    job.stop
    
Review its task log:
    
    job.log
    
View its results:
    
    job.results
    
Delete it:

    job.delete
    
List all jobs:

    Girdle::Job.list
    
License
-------

Copyright (c) 2011 Jamie Hodge

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.