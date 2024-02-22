json.extract! address, :id, :formatted_address, :postal_code, :place_id, :latitude, :longitude, :created_at, :updated_at
json.url address_url(address, format: :json)
