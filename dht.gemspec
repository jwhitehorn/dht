# -*- encoding: utf-8 -*-
require File.expand_path('../lib/dht/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Piotr Niełacny"]
  gem.email         = ["piotr.nielacny@gmail.com"]
  gem.description   = %q{Ruby DHT hash}
  gem.summary       = %q{Implementation of the Distributed Hash Table (DHT) in Ruby}
  gem.homepage      = "https://github.com/LTe/dht"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "dht"
  gem.require_paths = ["lib"]
  gem.version       = DHT::Hash::VERSION
  gem.required_ruby_version = '>= 1.9.3'
  gem.license       = 'MIT'

  gem.add_dependency "dcell"
end

