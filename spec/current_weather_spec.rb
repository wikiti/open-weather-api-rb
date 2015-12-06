require 'spec_helper'

describe OpenWeatherAPI::API do
  describe 'When fetching current weather' do
    let(:api) { OpenWeatherAPI::API.new( api_key: ENV['OPEN_WEATHER_API_KEY'], default_language: 'es', default_country_code: 'es' ) }

    it 'should retrieve data by city name' do
      expect(api.current(city: 'Santa Cruz de Tenerife')[:cod].to_i).to eq(200)
    end

    it 'should retrieve data by city id' do
      expect(api.current(id: 6360638)[:cod].to_i).to eq(200)
    end

    it 'should retrieve data by cities ids' do
      response = api.current(id: [6360638, 2511401])
      expect(response[:cod].to_i).not_to be >= 400
    end

    it 'should retrieve data by geolocation' do
      expect(api.current(lon: -16.20302, lat: 28.53924)[:cod].to_i).to eq(200)
    end

    it 'should retrieve data by zipcode' do
      expect(api.current(zipcode: 38190)[:cod].to_i).to eq(200)
    end

    it 'should retrieve data by bounding box' do
      expect(api.current(rectangle: { topleft: { lat: -16.3319, lon: 28.5046 }, bottomright: { lat: -16.1972, lon: 28.4400}, zoom: 10 })[:cod].to_i).to eq(200)
    end

    it 'should retrieve data by circle' do
      expect(api.current(circle: { lat: -16.3319, lon: 28.5046 }, cities_count: 2)[:cod].to_i).to eq(200)
    end

    it 'works with a given block' do
      json1, json2 = nil
      json1 = api.current(city: 'Santa Cruz de Tenerife') { |json| json2 = json }

      expect(json1).to eq(json2)
    end
  end
end