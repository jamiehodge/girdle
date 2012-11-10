# -*- encoding: utf-8 -*-
require File.expand_path('../lib/girdle/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Jamie Hodge"]
  gem.email         = ["jamiehodge@me.com"]
  gem.description   = %q{An Xgrid client}
  gem.summary       = %q{A client for submitting and managing Xgrid jobs}
  gem.homepage      = 'http://github.com/jamiehodge/girdle'

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "girdle"
  gem.require_paths = ['lib']
  gem.version       = Girdle::VERSION
  
  gem.add_development_dependency 'bundler'
  gem.add_development_dependency 'mocha'
  
  gem.add_dependency 'nokogiri'
  gem.add_dependency 'nokogiri-plist'
end
