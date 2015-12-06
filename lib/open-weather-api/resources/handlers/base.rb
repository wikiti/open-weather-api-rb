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
  end
end