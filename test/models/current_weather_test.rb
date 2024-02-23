require "test_helper"
require 'webmock/minitest'

class CurrentWeatherTest < ActiveSupport::TestCase
  setup do
    @postal_code = '10001'
    @current_weather = CurrentWeather.new(postal_code: @postal_code)
    @api_key = 'test_api_key'
    @fake_response = {
      "main" => {
        "temp" => 54.5,
        "feels_like" => 53.2,
        "temp_min" => 52.8,
        "temp_max" => 56.3,
        "humidity" => 56
      },
      "wind" => {
        "speed" => 1.5
      }
    }
    ENV['WEATHER_KEY'] = @api_key
    stub_request(:get, CurrentWeather::WEATHER_URI + '/weather')
      .with(query: {q: "#{@postal_code},us", appid: @api_key, units: 'imperial', exclude: 'minutely,hourly'})
      .to_return(status: 200, body: @fake_response.to_json, headers: {})
  end

  test 'fetches and saves the weather' do
    freeze_time do
      @current_weather.fetch_and_save_weather
      assert @current_weather.persisted?
      assert_equal 54.5, @current_weather.temp
      assert_equal 53.2, @current_weather.feels_like
      assert_equal 56.3, @current_weather.high_temp
      assert_equal 52.8, @current_weather.low_temp
      assert_equal 56, @current_weather.humidity
      assert_equal 1.5, @current_weather.wind_speed
      assert_in_delta 29.minutes.from_now, @current_weather.expires_at, 1.second
    end
  end

end
