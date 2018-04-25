
lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'polyhedral/version'

Gem::Specification.new do |spec|
  spec.name          = 'polyhedral'
  spec.version       = Polyhedral::VERSION
  spec.authors       = ['Megan McVey']
  spec.email         = ['shadowradiance@gmail.com']

  spec.summary       = 'Roll some dice. D&D Style'
  spec.homepage      = 'https://github.com/shadowradiance/polyhedral'
  spec.license       = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
