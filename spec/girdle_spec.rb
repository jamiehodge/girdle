require_relative 'spec_helper'

def plist
  <<-EOS
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
    </dict>
    </plist>
  EOS
end

describe Girdle do
  
  describe '::run' do
    
    it 'must call xgrid with default options' do
      Girdle.expects(:`).
        with('/usr/bin/xgrid -hostname localhost -auth None -format xml -failover YES -autocopy YES').
        returns(plist)
      Girdle.run
    end
    
    it 'must format commands and arguments' do
      Girdle.expects(:`).
        with('/usr/bin/xgrid -hostname localhost -auth None -format xml -failover YES -autocopy YES -job run /bin/echo hello').
        returns(plist)
      Girdle.run(job: 'run', cmd: '/bin/echo hello')
    end
  end
  
  
  describe '::run_batch' do
    
    it 'must pipe xml to xgrid using - argument' do
      Girdle.expects(:`).
        with('xml | /usr/bin/xgrid -hostname localhost -auth None -format xml -failover YES -autocopy YES -').
        returns(plist)
      Girdle.run_batch('xml')
    end
  end
end

