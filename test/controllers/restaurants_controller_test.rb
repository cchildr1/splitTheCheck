require 'test_helper'

class RestaurantsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @restaurant = restaurants(:one)
  end

  test "should get index" do
    get restaurants_url
    assert_response :success
  end

  test "should get new" do
    get new_restaurant_url
    assert_response :success
  end

  test "should create restaurant" do
    assert_difference('Restaurant.count') do
      post restaurants_url, params: { restaurant: { city: "test",  name: "testy the testy restaurant", state: "TE", streetaddress: "test street", zipcode: "11111" } }
    end

    assert_redirected_to restaurant_url(Restaurant.last)
  end

  test "should show restaurant" do
    get restaurant_url(@restaurant)
    assert_response :success
  end

  test "should get edit" do
    get edit_restaurant_url(@restaurant)
    assert_response :success
  end

  test "should update restaurant" do
    patch restaurant_url(@restaurant), params: { restaurant: { city: "test",  name: "testy the testy restaurant", state: "TE", streetaddress: "test street", zipcode: "11111" } }
    assert_redirected_to restaurant_url(@restaurant)
  end

  test "empty search redirects to index with message" do
    get search_page_url, params: { search: nil}
    assert_redirected_to '/'
  end

  test "search redirects to seach page with parameters" do
    get search_page_url, params: { search: "Test"}
    assert_response :success
  end
end
