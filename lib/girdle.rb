require 'bundler/setup'

require 'nokogiri'
require 'nokogiri-plist'

require_relative 'girdle/helpers'

require_relative 'girdle/version'
require_relative 'girdle/task'
require_relative 'girdle/specification'
require_relative 'girdle/job'
require_relative 'girdle/grid'
require_relative 'girdle/controller'
require_relative 'girdle/log_entry'

module Girdle
  extend self
  
  attr_writer :xgrid, :hostname, :auth,
    :password, :format, :failover, :autocopy
    
  def xgrid
    @xgrid ||= '/usr/bin/xgrid'
  end
  
  def hostname
    @hostname ||= 'localhost'
  end

  # None, Password, Kerberos
  def auth
    @auth ||= 'None'
  end

  def password
    @password ||= ''
  end
  
  # plain, xml
  def format
    @format ||= 'xml'
  end
  
  # YES, NO
  def failover
    @failover ||= 'YES'
  end
  
  # YES, NO
  def autocopy
    @autocopy ||= 'YES'
  end
  
  def run(options = {})
    options = default_options.merge(options)
    result = `#{xgrid} #{options_format(options)}`
    parse(result) if $?.to_i == 0
  end
  
  def run_batch(xml, options = {})
    options = default_options.merge(options)
    result = `echo "#{xml}" | #{xgrid} #{options_format(options)} -`
    parse(result) if $?.to_i == 0
  end
  
  private
  
    def options_format(options)
      options.map { |k,v| k == :cmd ? v : "-#{k} #{v}" }.join(' ')
    end
    
    def default_options
      opts = {
        hostname: hostname,
        auth:     auth,
        format:   format,
        failover: failover,
        autocopy: autocopy
      }
      opts[:password] == password if auth == 'Password'
      opts
    end
    
    def parse(xml)
      Nokogiri::PList(xml)
    end
    
end