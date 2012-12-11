# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'codesake/version'

Gem::Specification.new do |gem|
  gem.name          = "codesake"
  gem.version       = Codesake::VERSION
  gem.authors       = ["Paolo Perego"]
  gem.email         = ["paolo@armoredcode.com"]
  gem.description   = %q{codesake is the source code scanning engine for codesake.com}
  gem.summary       = %q{codesake is the source code scanning engine for codesake.com}
  gem.homepage      = "http://codesake.com"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]


  gem.add_dependency('trimmy')
  gem.add_dependency('rainbow')

  gem.add_development_dependency('rake')
  gem.add_development_dependency('rspec')
  # gem.add_development_dependency('cucumber')
  gem.add_development_dependency('aruba')
end
