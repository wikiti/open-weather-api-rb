module OpenWeatherAPI
  module Resources
    class ForecastHourly < Base

      def base_url
        return super + 'forecast/'
      end

      def build_params(parameters = {})
        super parameters.merge([city, city_id, geolocation].each{ |h| break h.handle if h.can? })
      end

      # Simple handlers
      def city
        Handlers::City.new @api_obj, @parameters
      end

      def city_id
        Handlers::CityID.new @api_obj, @parameters
      end

      def geolocation
        Handlers::Geolocation.new @api_obj, @parameters
      end

    end
  end
end
