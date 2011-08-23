require 'spec_helper'

describe Girdle::Task do
  
  it 'must have name, command, arguments and depends_on attributes' do
    task = Girdle::Task.new(
      name: 'name', 
      command: '/bin/echo',
      arguments: [],
      depends_on: []
      )
    task.name.must_equal 'name'
    task.command.must_equal '/bin/echo'
    task.arguments.must_equal []
    task.depends_on.must_equal []
    task.environment.must_equal Hash.new
  end
  
  
end