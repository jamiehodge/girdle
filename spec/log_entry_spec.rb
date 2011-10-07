require_relative 'spec_helper'

describe Girdle::LogEntry do
  
  before do
    @log = Girdle::LogEntry.new(message: 'message', time: 'time')
  end
  
  it 'must return entry message' do
    @log.message.must_equal 'message'
  end
  
  it 'must return entry time' do
    @log.time.must_equal 'time'
  end
end