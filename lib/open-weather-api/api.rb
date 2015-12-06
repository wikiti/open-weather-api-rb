module OpenWeatherAPI
  class API

    attr_accessor :api_key, :default_language, :default_country_code, :default_units

    def initialize(options = {})
      @api_key = options[:api_key] || options['api_key']
      @default_language = options[:default_language] || options['default_language'] || 'en'
      @default_country_code = options[:default_country_code] || options['default_country_code']
      @default_units =  options[:default_units] || options['default_units'] || 'metric'
    end

    def current(**args, &block)
      fetch_current.execute(**args, &block)
    end

    # Not yet implemented
    def forecast(type = :hourly, **args, &block)
      raise ArgumentError, "Invalid #{type} forecast type."

      self.send("fetch_forecast_#{type}").execute(**args, &block)
    end

    def icon_url(icon_code)
      "http://openweathermap.org/img/w/#{icon_code}.png"
    end

    private

    VALID_FORECAST_TYPES = [:hourly, :daily]

    def valid_forecast_type?(type)
      VALID_FORECAST_TYPES.include? type.to_sym
    end

    def fetch_current
      @current ||= Resources::Current.new self
    end

    def fetch_forecast_hourly
      @forecast_hourly ||= Resources::ForecastHourly.new self
    end

    def fetch_forecast_daily
      @forecast_daily ||= Resources::ForecastHourly.new self
    end
  end
end