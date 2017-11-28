module OpenWeatherAPI
  def self.configure(&block)
    raise ArgumentError, 'No block was given.' unless block

    api = Rails.configuration.open_weather_api = OpenWeatherAPI::API.new
    block.call(api)
    api
  end
end