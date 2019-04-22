require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @restaurant = restaurants(:one)
    @user = users(:one)
  end

  test "Add comment redirects to login page when user not logged in" do
    post restaurant_comments_url(@restaurant), params: { comment: { user_id: @user.id, content: "comment" } }
    assert_redirected_to new_user_session_url
  end

  test "add comment redirects to restaurants page when signed in" do
    sign_in @user
    post restaurant_comments_url(@restaurant), params: { comment: {user_id: @user.id, content: "comment" } }
    assert_redirected_to @restaurant
  end
end
