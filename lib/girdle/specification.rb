module Girdle
  
  class Specification
    
    attr_accessor :name, :notification_email, :tasks, :depends_on
    
    def initialize(options = {})
      @name = options[:name]
      @notification_email = options[:notification_email]
      @tasks = options[:tasks] || []
      @depends_on = options[:depends_on] || []
    end
    
    def to_plist
      Nokogiri::XML::Builder.new do |xml|
        xml.doc.create_internal_subset(
          'plist',
          '-//Apple Computer//DTD PLIST 1.0//EN',
          'http://www.apple.com/DTDs/PropertyList-1.0.dtd'
        )
        xml.plist(:version => '1.0') do
          xml.array do
            xml.dict do
              xml.key 'name'
              xml.string name
              xml.key 'notificationEmail'
              xml.string notification_email
              xml.key 'schedulerParameters'
              xml.dict do
                xml.key 'dependsOnJobs'
                xml.array do
                  depends_on.each do |dependency|
                    xml.string dependency
                  end
                end
              end
              xml.key 'taskSpecifications'
              xml.dict do
                tasks.each do |task|
                  xml.key task.name
                  xml.dict do
                    xml.key 'arguments'
                    xml.array do
                      task.arguments.each do |argument|
                        xml.string argument
                      end
                    end
                    xml.key 'command'
                    xml.string task.command
                    xml.key 'environment'
                    xml.dict do
                      task.environment.each do |k,v|
                        xml.key k
                        xml.string v
                      end
                    end
                    xml.key 'dependsOnTasks'
                    xml.array do
                      task.depends_on.each do |dependency|
                        xml.string dependency
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end.to_xml
    end
    
  end
  
end