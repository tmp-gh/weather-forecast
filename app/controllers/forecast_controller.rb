# frozen_string_literal: true

class ForecastController < ApplicationController
  def fetch
    @weather_data = if zipcode_params.present?
                      cache_temperture(zipcode_params)
                    elsif city_params
                      cache_temperture(city_params)
                    end
  end

  private

  def cache_temperture(*args)
    params = args.flatten
    key = params.join('_')
    @cached_value = Rails.cache.exist?(key)

    Rails.cache.fetch(key, expires_in: 30.minutes) do
      client = OpenWeather::Client.new
      if params.count > 1
        client.current_city(params)
      else
        client.current_zip(params)
      end
    end
  rescue StandardError => e
    flash[:error] = "no data available for the given address"
    redirect_to fetch_forecast_index_path
  end

  def zipcode_params
    @zipcode = params['zipcode']
  end

  def city_params
    @city = params['city']
    state = params['state']
    country = params['country']

    return unless @city.present? && state.present? && country.present?
    @city = params['city']
    [@city, state, country]
  end
end
