# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'misty/openstack/version'

Gem::Specification.new do |spec|
  spec.name          = "misty-cc"
  spec.version       = "0.1.0"
  spec.authors       = ["Hans-Georg Winkler"]
  spec.email         = ["hans-georg.winkler@sap.com"]

  spec.summary       = %q{OpenStack ConvergedCloud provider gem}
  spec.description   = %q{OpenStack ConvergedCloud provider gem}
  spec.license       = "Apache-2.0"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.rdoc_options = ['--charset=UTF-8']
  spec.extra_rdoc_files = %w[README.md LICENSE.md]

  spec.add_dependency 'misty', '>= 0.5.1'

  spec.add_development_dependency 'bundler',    '~> 1.10'
  spec.add_development_dependency 'rake',       '~> 10.0'
  spec.add_development_dependency 'minitest',   '~> 5.10'
  spec.add_development_dependency 'webmock',    '~> 1.24'
  spec.add_development_dependency 'vcr',        '~> 3.0'
  spec.add_development_dependency 'pry-byebug', '~> 3.4'
  spec.add_development_dependency 'dotenv',     '~> 2.2.0'
  spec.add_development_dependency 'byebug'
end
