require "test_helper"

class AddressesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @address = addresses(:one)
    @postal_code = @address.postal_code
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
      .with(
        headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Ruby'
      })
      .to_return(status: 200, body: @fake_response.to_json, headers: {})
  end

  test "should get index" do
    get addresses_url
    assert_response :success
  end

  test "should get new" do
    get new_address_url
    assert_response :success
  end

  test "should create address" do
    assert_difference("Address.count") do
      post addresses_url, params: { address: { formatted_address: @address.formatted_address, latitude: @address.latitude, longitude: @address.longitude, place_id: 'differentplaceid', postal_code: @address.postal_code } }
    end

    assert_redirected_to new_address_url
  end

  test "should show address" do
    get address_url(@address)
    assert_response :success
  end

  test "should get edit" do
    get edit_address_url(@address)
    assert_response :success
  end

  test "should update address" do
    patch address_url(@address), params: { address: { formatted_address: @address.formatted_address, latitude: @address.latitude, longitude: @address.longitude, place_id: @address.place_id, postal_code: @address.postal_code } }
    assert_redirected_to address_url(@address)
  end

  test "should destroy address" do
    assert_difference("Address.count", -1) do
      delete address_url(@address)
    end

    assert_redirected_to addresses_url
  end

  test "should not create address with duplicate place_id" do
    assert_no_difference('Address.count') do
      post addresses_url, params: { address: { formatted_address: @address.formatted_address, latitude: @address.latitude, longitude: @address.longitude, place_id: @address.place_id, postal_code: @address.postal_code } }
    end
    assert_response :unprocessable_entity
  end

end
