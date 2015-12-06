module OpenWeatherAPI
  module Resources
    class ForecastHourly < Base

      def base_url
        return super + 'forecast'
      end

      def build_params(parameters = {})
        super [city, city_id, geolocation].each{ |h| break h.handle if h.can? }
      end

      # Simple handlers
      def city
        City.new @api_obj, @parameters
      end

      def city_id
        CityID.new @api_obj, @parameters
      end

      def geolocation
        Geolocation.new @api_obj, @parameters
      end

    end
  end
end