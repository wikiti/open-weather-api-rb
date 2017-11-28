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

# Note that 'config' is an instance of `OpenWeatherAPI::API` (just name it as you like).
OpenWeatherAPI.configure do |config|
  # API key
  config.api_key = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"

  # Optionals
  config.default_language = 'es'     # 'en' by default
  config.default_country_code = 'es' # nil by default (ISO 3166-1 alfa2)
  config.default_units = 'metric'    # 'metric' by default
end
```

Outside of the configuration file, you can access the `api` object as follows:

````ruby
Rails.configuration.open_weather_api
````

### Generic

```ruby
open_weather_api = OpenWeatherAPI::API.new api_key: "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx", default_language: 'es', default_units: 'metric', default_country_code: 'es'
# ...
```

----------------------------

Finally, you can use the different resources of the API:

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

For more information about the API, visit [http://openweathermap.org/current](http://openweathermap.org/current).

### Hourly forecast (actually, every 3 hours, up to 5 days)

By city name:

````ruby
json = open_weather_api.forecast :hourly, city: 'Santa Cruz de Tenerife', country_code: 'es'
````

By city id:

````ruby
json = open_weather_api.forecast :hourly, id: 6360638
````

By geolocation:

````ruby
json = open_weather_api.forecast :hourly, lon: -16.20302, lat: 28.53924
````

For more information about the API, visit [http://openweathermap.org/forecast5](http://openweathermap.org/forecast5).

#### Daily forecast (up to 16 days)

Same as above, but changing `:hourly` to `:daily`. Also, you must add the `:days` to the resquests. Default is `1`.

By city name:

````ruby
json = open_weather_api.forecast :daily, city: 'Santa Cruz de Tenerife', country_code: 'es', days: 2
````

By city id:

````ruby
json = open_weather_api.forecast :daily, id: 6360638, days: 2
````

By geolocation:

````ruby
json = open_weather_api.forecast :daily, lon: -16.20302, lat: 28.53924, days: 2
````

For more information about the API, visit [http://openweathermap.org/forecast5](http://openweathermap.org/forecast5).

### Historical data

TODO

### Weather stations

TODO

### UV index

TODO

### Raw requests

You can also make your very own calls to the api:

````ruby
json = open_weather_api.raw 'route/to/my/resource', param1: 'param', param2: 'param', lang: 'es'
````

Note that it's not necessary to add `APPID` parameter to the call.

### Other

Retrieve icon url:

````ruby
open_weather_api.current city: 'Santa Cruz de Tenerife', country_code: 'es' do |json|
  puts "Icon url: #{api.icon_url json['weather'].first['icon']}"
end
````

You can add manually any parameter you need for each request, and they will override the computed parameters:

````ruby
open_weather_api.current city: 'Balashikha', country_code: 'ru', lang: 'ru', mypara: 'param'
````

Also, you can define the response format with the `:mode` parameters. Valid formats are `:json` (returns a `Hash`), `:xml` and `:html` (both return a `String`):

````ruby
open_weather_api.current city: 'Santa Cruz de Tenerife', mode: :xml do |xml_str|
  puts "XML data: #{xml_str}"
end
````

You can use ruby blocks to handle the response:

````ruby
open_weather_api.current city: 'Santa Cruz de Tenerife', country_code: 'es', mode: :json do |json|
  puts JSON.pretty_generate(json)
end
````

## Development

Clone this repository with

```
git clone git@github.com:wikiti/open-weather-api-rb.git
```

To run tests, just run rspec:

```
OPEN_WEATHER_API_KEY=your_api_key bundle exec rspec
```

## Authors ##

This project has been developed by:

| Avatar | Name | Nickname | Email |
| ------- | ------------- | --------- | ------------------ |
| ![](http://www.gravatar.com/avatar/2ae6d81e0605177ba9e17b19f54e6b6c.jpg?s=64)  | Daniel Herzog | Wikiti | [wikiti.doghound@gmail.com](mailto:wikiti.doghound@gmail.com) |
