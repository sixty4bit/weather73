class AddHiLoToCurrentWeather < ActiveRecord::Migration[7.1]
  def change
    add_column :current_weathers, :high_temp, :decimal
    add_column :current_weathers, :low_temp, :decimal
  end
end
