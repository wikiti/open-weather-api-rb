# OpenWeatherApi wrapper for Ruby

<div align="center">
![](doc/icon.png)
<div align="left">

Simple wrapper for Open Weather Map API.

Please visit the this [link](http://openweathermap.org/api) for more information.

## Installation

Add this line to your application's Gemfile:

    gem 'open-weather-api'

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install open-weather-api

## Usage

First, you need to init the API:

### Rails

```ruby
# config/initializers/open-weather-api.rb

Rails.configuration.open_weather_api = OpenWeatherAPI::API.new api_key: ENV['OPEN_WEATHER_API_KEY'], language: 'es', units: 'metric'
```

`language`, `default_country_code` and `metrics` are optional values, with defaults `'en'`, `nil` and `'metric'`.

### Other

```ruby
open_weather_api = OpenWeatherAPI::API.new api_key: ENV['OPEN_WEATHER_API_KEY'], language: 'es', units: 'metric'
# ...
```

----------------------------

Finally, you can use the different resources of the API:

**NOTE**: You can add manually any parameter you need for each request.

### Current Weather

By city name:

````ruby
json = open_weather_api.current city: 'Santa Cruz de Tenerife', country_code: 'es'
````

By city id:

````ruby
json = open_weather_api.current id: 6360638
````

By multiple cities ids:

````ruby
json = open_weather_api.current id: [6360638, 2511401]
````

By geolocation:

````ruby
json = open_weather_api.current lon: -16.20302, lat: 28.53924
````

By zipcode:

````ruby
json = open_weather_api.current zipcode: 38190, country_code: 'es'
````

By a geolocated rectangle:

````ruby
json = open_weather_api.current rectangle: { topleft: { lat: -16.3319, lon: 28.5046 }, bottomright: { lat: -16.1972, lon: 28.4400}, zoom: 10 }
````

By a geolocated circle (**WARNING**: Unexpected behaviour by API):

````ruby
json = open_weather_api.current circle: { lat: -16.3319, lon: 28.5046 }, cities_count: 2
````

You can also use ruby blocks to handle the response:

````ruby
json = open_weather_api.current city: 'Santa Cruz de Tenerife', country_code: 'es' do |json|
  puts JSON.pretty_generate(json)
end
````

For more information about the API, visit [http://openweathermap.org/current](http://openweathermap.org/current).

### Forecast

TODO.

### Other

Retrieve icon url:

````ruby
api.current city: 'Santa Cruz de Tenerife', country_code: 'es' do |json|
  puts "Icon url: #{api.icon_url json['weather'].first['icon']}"
end
````

## Authors ##

This project has been developed by:

| Avatar | Name | Nickname | Email |
| ------- | ------------- | --------- | ------------------ |
| ![](http://www.gravatar.com/avatar/2ae6d81e0605177ba9e17b19f54e6b6c.jpg?s=64)  | Daniel Herzog | Wikiti | [wikiti.doghound@gmail.com](mailto:wikiti.doghound@gmail.com)

## Contributing

1. Fork it ( [https://gitlab.com/wikiti-random-stuff/open-weather-api/fork/new](https://gitlab.com/wikiti-random-stuff/open-weather-api/fork/new) )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
