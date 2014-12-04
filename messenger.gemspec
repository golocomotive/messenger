# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'messenger/version'

Gem::Specification.new do |spec|
  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'factory_girl_rails'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'spring'

  spec.add_dependency 'rails'
  spec.add_dependency 'uuid'

  spec.authors       = ['Martin Streicher']
  spec.description   = %q{A Rails engine to provide internal messaging.}
  spec.email         = ['martin.streicher@gmail.com']
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.files         = Dir['{app,config,db,lib}/**/*'] + ['Rakefile', 'README.md']
  spec.homepage      = ''
  spec.license       = 'MIT'
  spec.name          = 'messenger'
  spec.require_paths = ['lib']
  spec.summary       = %q{A Rails engine to provide internal messaging.}
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.version       = Messenger::VERSION
end
