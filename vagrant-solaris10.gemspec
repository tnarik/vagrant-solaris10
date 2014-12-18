# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vagrant-solaris10/version'

Gem::Specification.new do |spec|
  spec.name          = "vagrant-solaris10"
  spec.version       = Vagrant::Solaris10::VERSION
  spec.authors       = ["Tnarik Innael"]
  spec.email         = ["tnarik@lecafeautomatique.co.uk"]
  spec.description   = "Guest plugin for Vagrant Solaris10"
  spec.summary       = "Guest plugin for Vagrant Solaris10"
  spec.homepage      = "https://github.com/tnarik/vagrant-solaris10"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  # development dependencies  
  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end