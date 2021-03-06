# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'date_manager/version'
Gem::Specification.new do |spec|
  spec.name = "date_manager"
  spec.version = DateManager::VERSION
  spec.authors = ["Fernando"]
  spec.email = ["fgonzalezaguilera@gmail.com"]
  spec.description = %q{Parse, validate, manipulate, and display dates.}
  spec.summary = %q{}
  spec.homepage = ""
  spec.license = "MIT"
  spec.files = `git ls-files`.split($/)
  spec.executables = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'rspec'
end