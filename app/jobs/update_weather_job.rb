class UpdateWeatherJob < ApplicationJob
  queue_as :default

  def perform(*args)
    CurrentWeather.where('expires_at IS NULL OR expires_at < ?', Time.current).each do |weather|
      weather.fetch_and_save_weather
    end
    UpdateWeatherJob.set(wait: 1.minute).perform_later
  end
end
