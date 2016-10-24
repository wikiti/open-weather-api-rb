# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'open-weather-api/version'

Gem::Specification.new do |spec|
  spec.name          = "open-weather-api"
  spec.version       = OpenWeatherAPI::VERSION
  spec.authors       = ["Wikiti"]
  spec.email         = ["wikiti.doghound@gmail.com"]
  spec.summary       = %q{Simple wrapper for Open Weather Map API}
  spec.description   = %q{Simple wrapper for Open Weather Map API. The API description may be found here: http://openweathermap.org/api}
  spec.homepage      = "https://gitlab.com/wikiti-random-stuff/open-weather-api"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "rest-client", "~> 2.0"

  spec.add_development_dependency "rspec"
  spec.add_development_dependency "fuubar"
end
