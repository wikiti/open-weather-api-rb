raise "You MUST setup 'OPEN_WEATHER_API_KEY' env variable before running tests!" unless ENV['OPEN_WEATHER_API_KEY']

require 'bundler/setup'
Bundler.setup

lib = File.expand_path('../../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'open-weather-api'

RSpec.configure do |config|
  # some (optional) config here
end