require 'spec_helper'

describe OpenWeatherAPI::API do
  describe 'When fetching hourly forecast weather' do
    let(:api) { OpenWeatherAPI::API.new( api_key: ENV['OPEN_WEATHER_API_KEY'], default_language: 'es', default_country_code: 'es' ) }

    it 'should retrieve data by city name' do
      expect(api.forecast(:hourly, city: 'Santa Cruz de Tenerife')[:cod].to_i).to eq(200)
    end

    it 'should retrieve data by city id' do
      expect(api.forecast(:hourly, id: 6360638)[:cod].to_i).to eq(200)
    end

    it 'should retrieve data by geolocation' do
      expect(api.forecast(:hourly, lon: -16.20302, lat: 28.53924)[:cod].to_i).to eq(200)
    end

    it 'works with a given block' do
      json1, json2 = nil
      json1 = api.forecast(:hourly, city: 'Santa Cruz de Tenerife') { |json| json2 = json }

      expect(json1).to eq(json2)
    end

    it 'works with xml format' do
      expect(api.forecast(:hourly, city: 'Santa Cruz de Tenerife', mode: :xml)).not_to be_nil
    end

    it 'works with html format' do
      expect(api.forecast(:hourly, city: 'Santa Cruz de Tenerife', mode: :html)).not_to be_nil
    end
  end
end