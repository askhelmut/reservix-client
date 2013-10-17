lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)
require 'askhelmut-reservix/version'

Gem::Specification.new do |spec|
  spec.name        = 'askhelmut-reservix'
  spec.version     = AskhelmutReservix::VERSION
  spec.platform    = Gem::Platform::RUBY
  spec.authors     = ["Niels Hoffmann"]
  spec.email       = ["niels@askhelmut.com"]
  spec.homepage    = 'http://askhelmut.com'
  spec.summary     = "A wrapper for the Reservix REST api."
  spec.description = "A wrapper for the Reservix REST api. It provides simple methods to retireve resources form the Reservix REST api."

  spec.required_rubygems_version = '>= 1.3.5'

  spec.add_dependency('httmultiparty', '~> 0.3.0')
  spec.add_dependency('hashie', '~> 2.0')

  spec.add_development_dependency('bundler', '~> 1.0')
  spec.add_development_dependency('guard', '~> 1.0')
  spec.add_development_dependency('rb-fsevent', '~> 0.9')

  spec.files        = Dir.glob("lib/**/*") + %w(README.md)
  spec.require_path = 'lib'
end
