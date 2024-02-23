class AddPlaceIdIndexToAddress < ActiveRecord::Migration[7.1]
  def change
    add_index :addresses, :place_id, unique: true
  end
end
