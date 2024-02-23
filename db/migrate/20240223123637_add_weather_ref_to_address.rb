class AddWeatherRefToAddress < ActiveRecord::Migration[7.1]
  def change
    add_reference :addresses, :current_weather, null: false, foreign_key: true
  end
end
