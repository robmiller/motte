# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'motte/version'

Gem::Specification.new do |spec|
  spec.name          = "motte"
  spec.version       = Motte::VERSION
  spec.authors       = ["Rob Miller"]
  spec.email         = ["rob@bigfish.co.uk"]
  spec.summary       = %q{Parser of caselaw stored on BAILII}
  spec.description   = %q{BAILII is a database of British and Irish caselaw; this tool parses cases found there and extracts information from them.}
  spec.homepage      = "https://github.com/robmiller/motte"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "nokogiri", "~> 1.6"

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
