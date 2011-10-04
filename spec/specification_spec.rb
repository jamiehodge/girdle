require_relative 'spec_helper'

describe Girdle::Specification do
  
  before do
    @spec = Girdle::Specification.new(
      name: 'specification name',
      notification_email: 'email@example.com',
      tasks: [
        Girdle::Task.new(
          name: 'task name', 
          command: '/bin/echo', 
          arguments: ['hello'], 
          depends_on: ['another task'],
          environment: {'MY_ENV_VARIABLE' => 'MY_VALUE'}
        )
      ],
      depends_on: [456, 789]
    )
  end
  
  it 'must have name, notification_email, tasks and depends_on accessors' do
    @spec.name.must_equal 'specification name'
    @spec.notification_email.must_equal 'email@example.com'
    @spec.tasks.size.must_equal 1
  end
  
  it 'must append tasks' do
    @spec.tasks.size.must_equal 1
    @spec.tasks << Girdle::Task.new
    @spec.tasks.size.must_equal 2
  end
  
  it 'must render itself as a plist' do
    plist = <<-EOS
<?xml version="1.0"?>
<!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <array>
    <dict>
      <key>name</key>
      <string>specification name</string>
      <key>notificationEmail</key>
      <string>email@example.com</string>
      <key>schedulerParameters</key>
      <dict>
        <key>dependsOnJobs</key>
        <array>
          <string>456</string>
          <string>789</string>
        </array>
      </dict>
      <key>taskSpecifications</key>
      <dict>
        <key>task name</key>
        <dict>
          <key>arguments</key>
          <array>
            <string>hello</string>
          </array>
          <key>command</key>
          <string>/bin/echo</string>
          <key>environment</key>
          <dict>
            <key>MY_ENV_VARIABLE</key>
            <string>MY_VALUE</string>
          </dict>
          <key>dependsOnTasks</key>
          <array>
            <string>another task</string>
          </array>
        </dict>
      </dict>
    </dict>
  </array>
</plist>
    EOS
    @spec.to_plist.must_equal plist
  end
  
end