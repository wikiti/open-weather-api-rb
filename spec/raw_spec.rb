require 'spec_helper'

describe OpenWeatherAPI::API do
  let(:api) do
    OpenWeatherAPI::API.new(api_key: ENV['OPEN_WEATHER_API_KEY'],
                            default_language: 'es',
                            default_country_code: 'es')
  end

  describe 'When fetching raw rest requests with valid data' do
    it 'should work' do
      expect(api.raw("weather", q: 'Santa Cruz de Tenerife,ES')[:cod].to_i).to eq(200)
    end
  end

  describe 'When fetching raw rest requests with invalid data' do
    it 'should fail' do
      expect { api.raw("undefined_resource", q: 'whatever', mode: :raw) }
        .to raise_error(RuntimeError)
    end
  end
end
