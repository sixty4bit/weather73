class CurrentWeather < ApplicationRecord
  include HTTParty
  WEATHER_URI = 'https://api.openweathermap.org/data/2.5'
  base_uri WEATHER_URI

  def fetch_and_save_weather
    return if expires_at.present? && expires_at > Time.now
    api_key = ENV['WEATHER_KEY']
    query = {q: "#{postal_code},us", appid: api_key, units: 'imperial', exclude: 'minutely,hourly' }
    response = self.class.get('/weather', query: query)
    if response.success?
      data = response.parsed_response
      data = data.is_a?(Hash) ? data : JSON.parse(data)
      self.temp = data.dig('main', 'temp')
      self.feels_like = data.dig('main', 'feels_like')
      self.high_temp = data.dig('main', 'temp_max')
      self.low_temp = data.dig('main', 'temp_min')
      self.humidity = data.dig('main', 'humidity')
      self.wind_speed = data.dig('wind', 'speed')
      self.expires_at = 29.minutes.from_now
      self.save!
    end
    self
  end
end
