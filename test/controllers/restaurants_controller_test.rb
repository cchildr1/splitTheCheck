require 'test_helper'

class RestaurantsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @restaurant = restaurants(:one)
    @user = users(:one)
  end

  test "should get index" do
    get restaurants_url
    assert_response :success
  end

  test "should get new with logged in user" do
    sign_in @user
    get new_restaurant_url
    assert_response :success
  end

  test "should redirect to login when user not logged in on new" do
    get new_restaurant_url
    assert_redirected_to new_user_session_url
  end

  test "should create restaurant with logged in user" do
    sign_in @user
    assert_difference('Restaurant.count') do
      post restaurants_url, params: { restaurant: { city: "test",  name: "testy the testy restaurant", state: "TE", streetaddress: "test street", zipcode: "11111" } }
    end

    assert_redirected_to restaurant_url(Restaurant.last)
  end

  test "should redirect to login in page on create restaurant without logged in user" do
    post restaurants_url, params: { restaurant: { city: "test",  name: "testy the testy restaurant", state: "TE", streetaddress: "test street", zipcode: "11111" } }
    assert_redirected_to new_user_session_url
  end

  test "should show restaurant" do
    get restaurant_url(@restaurant)
    assert_response :success
  end

  test "should get edit with logged in user" do
    sign_in @user
    get edit_restaurant_url(@restaurant)
    assert_response :success
  end

  test "should redirect to log in page without logged in user" do
    get edit_restaurant_url(@restaurant)
    assert_redirected_to new_user_session_url
  end

  test "should update restaurant with logged in user" do
    sign_in @user
    patch restaurant_url(@restaurant), params: { restaurant: { city: "test",  name: "testy the testy restaurant", state: "TE", streetaddress: "test street", zipcode: "11111" } }
    assert_redirected_to restaurant_url(@restaurant)
  end

  test "should redirect to login page when update restaurant without logged in user" do
    patch restaurant_url(@restaurant), params: { restaurant: { city: "test",  name: "testy the testy restaurant", state: "TE", streetaddress: "test street", zipcode: "11111" } }
    assert_redirected_to new_user_session_url
  end

  test "empty search redirects to index with message" do
    get search_page_url, params: { search: nil}
    assert_redirected_to '/'
  end

  test "search redirects to seach page with parameters" do
    get search_page_url, params: { search: "Test"}
    assert_response :success
  end

   test "upvote should redirect to login in page without user" do
     get restaurants_upvote_url(@restaurant)
     assert_redirected_to new_user_session_url
   end

  test "upvote should create a vote when logged in" do
    sign_in @user
    assert_difference 'Vote.count' do
      get restaurants_upvote_url(@restaurant)
    end
    assert_redirected_to restaurant_url(Restaurant.last)
  end

  test "downvote should create a vote when logged in" do
    sign_in @user
    assert_difference 'Vote.count' do
      get restaurants_downvote_url(@restaurant)
    end
    assert_redirected_to restaurant_url(Restaurant.last)
  end

  test "downvote should redirect to login page without user" do
    get restaurants_downvote_url(@restaurant)
    assert_redirected_to new_user_session_url
  end
end
