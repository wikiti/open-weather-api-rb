module OpenWeatherAPI
  module Resources
    class Base

      attr_reader :api_obj

      def initialize(api_obj)
        @api_obj = api_obj
      end

      def execute(**hash, &block)
        @parameters = hash
        setup_indifferent_access(@parameters)

        # Let's use json
        response = RestClient.send :get, base_url, params: build_params(@parameters)
        raise "Invalid response." unless response.code == 200

        # Handle the response format
        response = self.send "handle_response_#{mode}", response

        # Handle the block
        return block.call(response) if block_given?
        response
      end

      private

      def mode
        (@parameters[:mode] || :json).to_s.to_sym
      end

      def handle_response_raw(response)
        response
      end

      def handle_response_json(response)
        json = JSON.parse(response.body)
        setup_indifferent_access(json)
      end

      def handle_response_xml(response)
        response.body
      end

      def handle_response_html(response)
        response.body
      end

      def base_url
        "http://api.openweathermap.org/data/#{API::VERSION || '2.5'}/"
      end

      def setup_indifferent_access(sub_hash)
        sub_hash.default_proc = proc{|h, k| h.key?(k.to_s) ? h[k.to_s] : nil}
        sub_hash.each { |k, v| setup_indifferent_access(v) if v.is_a?(Hash) }
      end

      def build_params(parameters = {})
        {
          APPID: @api_obj.api_key,
          lang:  @api_obj.default_language,
          units: @api_obj.default_units
        }.merge(parameters)
      end
    end
  end
end
