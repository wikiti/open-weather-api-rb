module OpenWeatherAPI
  module Resources

     class QueryHandler
      def initialize(api_obj, parameters = {})
        @api_obj = api_obj
        @parameters = parameters
      end

      def handle
        build if can?
      end

      def can?
        value != nil
      end

      private

      def value
        true
      end

      def build
        @parameters
      end

      def country_code
        @parameters[:country_code] || @parameters[:cc] || @api_obj.default_country_code
      end

      def cities_count
        @parameters[:count] || @parameters[:cnt] || @parameters[:cities_count]
      end

      def cluster
        @parameters[:cluster] if @parameters[:cluster].to_s == 'yes' || @parameters[:cluster].to_s == 'no'
      end

      def fill(hash)
        hash[:cnt]     = cities_count if cities_count
        hash[:cluster] = cluster if cluster

        hash
      end

    end

    class City < QueryHandler
      private

      def build
        { q: [value, country_code].compact.flatten.join(',') }
      end
      
      def value
        @parameters[:city]
      end
    end

    class CityID < QueryHandler
      def multiple?
        value.is_a? Array
      end

      private

      def build
        { id: [value].flatten.compact.join(',') }
      end

      def value
        @parameters[:id] || @parameters[:city_id]
      end
    end

    class Geolocation < QueryHandler
      def can?
        latitude != nil && longitude != nil
      end

      private

      def build
        { lat: latitude, lon: longitude }
      end

      def latitude
        @parameters[:latitude] || @parameters[:lat]
      end

      def longitude
        @parameters[:longitude] || @parameters[:lon]
      end
    end
  end
end