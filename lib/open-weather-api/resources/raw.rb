module OpenWeatherAPI
  module Resources
    class Raw < Base

      def execute(resource = '/', **args, &block)
        @resource = resource
        super(**args, &block)
      end

      def base_url
        return super + @resource
      end
    end
  end
end