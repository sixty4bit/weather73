class Address < ApplicationRecord

  validates :place_id, uniqueness: true

  belongs_to :current_weather
end
