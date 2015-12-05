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

        response = request
        raise "Invalid response." unless response.code == 200

        json = JSON.parse(response.body)

        return block.call(json) if block_given?
        json
      end

      private

      def request(type = :get)
        RestClient.send type, base_url, params: build_params(@parameters), accept: :json
      end

      def base_url
        'http://api.openweathermap.org/data/2.5/'
      end

      def setup_indifferent_access(sub_hash)
        sub_hash.default_proc = proc{|h, k| h.key?(k.to_s) ? h[k.to_s] : nil}
        sub_hash.each { |k, v| setup_indifferent_access(v) if v.is_a?(Hash) }
      end

      def build_params(parameters = {})
        {
          APPID: @api_obj.api_key,
          lang:  @api_obj.default_language
        }.merge(parameters)
      end
    end
  end
end