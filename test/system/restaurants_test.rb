require "application_system_test_case"

class RestaurantsTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers
  setup do
    @restaurant = restaurants(:one)
    @user = users(:one)
  end

  test "visiting the index" do
    visit restaurants_url
    assert_selector "h1", text: "Restaurants"
  end

  test "logging in" do
    visit restaurants_url
    click_on "Login"
    fill_in "user_email", with: @user.email
    fill_in "user_password", with: "password"
    click_on "Log in"
    assert_selector "p", text: "Logged in as " + @user.email
  end


  test "creating a Restaurant after login" do
    sign_in @user
    visit restaurants_url
    click_on "New Restaurant"

    fill_in "City", with: @restaurant.city
    fill_in "Name", with: @restaurant.name
    fill_in "State", with: @restaurant.state
    fill_in "Street Address", with: @restaurant.streetaddress
    fill_in "Zip Code", with: @restaurant.zipcode
    click_on "Create Restaurant"

    assert_text "Restaurant was successfully created"
    click_on "Back"
  end

  test "updating a Restaurant after login" do
    sign_in @user
    visit restaurants_url
    click_on @restaurant.name.to_s, match: :first
    click_on "Edit"
    fill_in "City", with: @restaurant.city
    fill_in "Name", with: @restaurant.name
    fill_in "State", with: @restaurant.state
    fill_in "Street Address", with: @restaurant.streetaddress
    fill_in "Zip Code", with: @restaurant.zipcode
    click_on "Update Restaurant"

    assert_text "Restaurant was successfully updated"
    click_on "Back"
  end

  test "shows thumbs up when restaurant splits the check" do
    restaurant = restaurants(:splits)
    visit restaurants_url
    click_on restaurant.name.to_s, match: :first
    assert page.has_css?('.splitst')
  end

  test "shows thumbs down when restaurant doesn't split the check" do
    restaurant = restaurants(:two)
    visit restaurants_url
    click_on restaurant.name.to_s, match: :first
    assert page.has_css?('.splitsf')
  end

  test "shows shrug when votes are tied" do
    visit restaurants_url
    click_on @restaurant.name.to_s, match: :first
    assert_text "¯\\_(ツ)_/¯"
  end

  test "upvoted restaurant changes from shrug to thumbs up" do
    restaurant = restaurants(:reform)
    sign_in @user
    visit restaurants_url
    click_on restaurant.name.to_s, match: :first
    click_on "Upvote"
    assert_text restaurant.name.to_s + " upvoted"
    assert_text "¯\\_(ツ)_/¯"
    click_on "Upvote"
    assert page.has_css?('.splitst')
  end

  test "downvoted restaurant changes from shrug to thumbs down" do
    sign_in @user
    restaurant = restaurants(:splits)
    visit restaurants_url
    click_on restaurant.name.to_s, match: :first
    click_on "Downvote"
    assert_text restaurant.name.to_s + " downvoted"
    assert_text "¯\\_(ツ)_/¯"
    click_on "Downvote"
    assert page.has_css?('.splitsf')
  end

  test "empty search redirects to main page with message" do
    visit restaurants_url
    click_on "Search"
    assert_text "Empty Search Field"
  end

  test "searching pulls the correct result" do
    restaurant = restaurants(:two)
    visit restaurants_url
    fill_in "Search", with: restaurant.name.to_s
    click_on "Search"
    assert_text restaurant.streetaddress
    assert_no_text restaurants(:one).name.to_s
  end

  test "can sign up a new user" do
    visit restaurants_url
    click_on "Sign up"
    fill_in "Email", with: "test@notest.com"
    fill_in "Password", with: "testing"
    fill_in "Password confirmation", with: "testing"
    click_button "Sign up"
    assert_text "Welcome! You have signed up successfully."
    assert_text "Logged in as test@notest.com."
  end

  test "Add a comment" do
    sign_in @user
    visit restaurants_url
    click_on @restaurant.name
    fill_in "comment_content", with: "This is a comment"
    click_on "Create Comment"
    assert_text "This is a comment"
  end

  test "Favorite a restaurant" do
    sign_in @user
    visit restaurants_url
    click_on @restaurant.name
    click_on "Add to favorites"
    assert_text "Restaurant has been favorited"
  end

  test "unfavorite a restaurant" do
    sign_in @user
    visit restaurants_url
    click_on @restaurant.name
    click_on "Add to favorites"
    assert_text "Restaurant has been favorited"
    click_on "Remove from favorites"
    assert_text "Restaurant no longer in favorites"
  end
end
