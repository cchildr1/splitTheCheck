require 'test_helper'

class FavoriteControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @restaurant = restaurants(:one)
    @user = users(:one)
  end

  test "create favorite when not logged in redirects to login page" do
    post favorite_index_url(@restaurant), params: {format: @user.id }
    assert_response 401
  end

  test "create favorite when logged in creates a favorite" do
    sign_in @user
    assert_difference "Favorite.count" do
      post favorite_index_url(@restaurant), params: {format: @user.id}
    end
  end

end
