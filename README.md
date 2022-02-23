# README

# Weather-Forecast

Weather-forecast application is a webfacing component that provide weather forecast services. User can request this service by entering only zipcode or city/state/country combinations to retrieve forecast information. This application is implemented with test coverage, front UI and backend logic .

## Table of Contents

- [Ruby version](#Ruby-version)
- [System dependencies](#System-dependencies)
  - [Installation](#installation)
- [Usage](#usage)
- [Configuration](#configuration)
- [Cache](#Cache)
- [Current Weather](#current-weather)
- [Errors](#errors)
- [Rspec](#Rspec)
- [Resources](#resources)

## Ruby version

```
ruby "2.7.3"
```

## System dependencies

### Installation

Add to Gemfile.

```
gem 'open-weather-ruby-client'
```

Run `bundle install`.

## Usage

Use an access token obtained from [API Keys](https://home.openweathermap.org/api_keys) on the OpenWeather website after registration.

It looks something like below api_key.

```ruby
  api_key: "1a2b3c4d5a6b7c8d9a8b7c6d5a4b3c2d1"
```

## Configuration

Configure the api globally by placing this configuration in application.rb file for usage of api key in development and testing.

```ruby
OpenWeather::Client.configure do |config|
  config.api_key = '1a2b3c4d5a6b7c8d9a8b7c6d5a4b3c2d1'
  config.user_agent = 'OpenWeather Ruby Client/1.0'
end
```

## Cache

Cache is enabled and implemented for this feature. Whenever user submits a request, for that params combination if the data is fetched, it will store in cache for 30 mins. When user request for the second time, the data is pull from cache instead of api call. In UI, cached value column is the indicator for this feature.

## Database creation

Database is not used for this project. All the data is retrieved through 3rd party api services.

### Current Weather

Returns current weather with below values

```ruby
data = client.current_weather(city: 'London') # => OpenWeather::Models::City::Weather

City Name # => 'London'
Date # => Time
Temp # => 282.57
Temp_max_f # => 50.0, degrees Farenheit
Temp_min_f # => 25.0, degrees Farenheit
```

## Errors

All errors that return HTTP codes 400-600 result in either `Faraday::ResourceNotFound`, `Faraday::ConnectionFailed` or [OpenWeather::Errors::Fault](lib/open_weather/errors/fault.rb) exceptions.

## Rspec

For unit testing Rspec is used. Only basic scenarios are covered in this testing.

## Resources

OpenWeather API resources and gem related information can be found here

- [OpenWeather API README](https://github.com/dblock/open-weather-ruby-client)
- [OpenWeather API Documentation](https://openweathermap.org/api)
