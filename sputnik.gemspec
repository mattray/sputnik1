# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sputnik/version'

Gem::Specification.new do |gem|
  gem.name          = "sputnik"
  gem.version       = Sputnik::VERSION
  gem.authors       = ["Charles Lowell"]
  gem.email         = ["cowboyd@thefrontside.net"]
  gem.description   = %q{manage your sputnik profile}
  gem.summary       = %q{discover, install, develop and share your Sputnik profile}
  gem.homepage      = "http://github.com/sputnik"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'mixlib-cli'

  gem.add_development_dependency "rspec"
  gem.add_development_dependency "rspec-spies"
end
