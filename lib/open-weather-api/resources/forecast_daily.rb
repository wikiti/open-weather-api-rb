module OpenWeatherAPI
  module Resources
    class ForecastDaily < ForecastHourly

      def base_url
        return super + 'daily/'
      end

      def build_params(parameters = {})
        parameters.merge!(cnt: days)
        super(parameters)
      end

      def days
        @parameters[:days] || @parameters[:n_days] || @parameters[:cnt]  || @parameters[:count]
      end
    end
  end
end