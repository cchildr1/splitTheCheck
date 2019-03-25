require "application_system_test_case"

class RestaurantsTest < ApplicationSystemTestCase
  setup do
    @restaurant = restaurants(:one)
  end

  test "visiting the index" do
    visit restaurants_url
    assert_selector "h1", text: "Restaurants"
  end

  test "creating a Restaurant" do
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

  test "updating a Restaurant" do
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
    visit restaurants_url
    click_on restaurant.name.to_s, match: :first
    click_on "Upvote"
    assert_text restaurant.name.to_s + " upvoted"
    assert_text "¯\\_(ツ)_/¯"
    click_on "Upvote"
    assert page.has_css?('.splitst')
  end

  test "downvoted restaurant changes from shrug to thumbs down" do
    restaurant = restaurants(:splits)
    visit restaurants_url
    click_on restaurant.name.to_s, match: :first
    click_on "Downvote"
    assert_text restaurant.name.to_s + " downvoted"
    assert_text "¯\\_(ツ)_/¯"
    click_on "Downvote"
    assert page.has_css?('.splitsf')
  end

end
