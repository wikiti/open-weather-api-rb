require 'open-weather-api/version'

# Dependencies
require 'uri'
require 'rest-client'
require 'json'

# Resources
require 'open-weather-api/resources/base'
require 'open-weather-api/resources/raw'
require 'open-weather-api/resources/current'
require 'open-weather-api/resources/forecast_hourly'

# Handlers
require 'open-weather-api/resources/handlers/base'
require 'open-weather-api/resources/handlers/current'

# Configuration
require 'open-weather-api/config'

# Main file
require 'open-weather-api/api'