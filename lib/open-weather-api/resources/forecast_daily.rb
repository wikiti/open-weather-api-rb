module OpenWeatherAPI
  module Resources
    class ForecastDaily < ForecastHourly

      def base_url
        return super + 'daily/'
      end

      def build_params(parameters = {})
        super(parameters.merge(cnt: days))
      end

      def days
        @parameters[:days] || @parameters[:n_days] || @parameters[:cnt]  || @parameters[:count]
      end
    end
  end
end
