class CreateCurrentWeathers < ActiveRecord::Migration[7.1]
  def change
    create_table :current_weathers do |t|
      t.string :postal_code, null: false
      t.decimal :temp
      t.decimal :feels_like
      t.decimal :humidity
      t.decimal :wind_speed
      t.datetime :expires_at

      t.timestamps
    end

    add_index :current_weathers, :postal_code, unique: true
    add_index :current_weathers, :expires_at
  end
end
