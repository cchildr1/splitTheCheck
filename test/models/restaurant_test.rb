require 'test_helper'

class RestaurantTest < ActiveSupport::TestCase

  setup do
    @test = Restaurant.new
    @test.name = "name"
    @test.streetaddress = "123 street street"
    @test.city = "town"
    @test.state = "GA"
    @test.zipcode = "31257"
    @restaurant = restaurants(:two)
  end

  test "model can be created and valid" do
    assert @test.valid?
  end

  test "model requires name" do
    @test.name = nil
    assert_not @test.valid?
    assert_equal [:name], @test.errors.keys
  end

  test "model requires street address" do
    @test.streetaddress = nil
    assert_not @test.valid?
    assert_equal [:streetaddress], @test.errors.keys
  end

  test "model requires city" do
    @test.city = nil
    assert_not @test.valid?
    assert_equal [:city], @test.errors.keys
  end

  test "model requires state" do
    @test.state = nil
    assert_not @test.valid?
    assert_equal [:state], @test.errors.keys
  end

  test "model requires zipcode" do
    @test.zipcode = nil
    assert_not @test.valid?
    assert_equal [:zipcode], @test.errors.keys
  end

  test "model requires zipcode to be numbers" do
    @test.zipcode = "not numbers"
    assert_not @test.valid?
    assert_equal [:zipcode], @test.errors.keys
  end

  test "search returns proper result" do
    searchList = Restaurant.search("test")
    assert_includes searchList, @restaurant
    assert_not_includes searchList, restaurants(:one)
    assert_not_includes searchList, restaurants(:splits)
    assert_not_includes searchList, restaurants(:reform)
  end

  test "sum votes returns proper result" do
    assert_equal -1, @restaurant.sum_votes
  end

  test "sum upvotes returns proper result" do
    assert_equal 1, @restaurant.sum_upvotes
  end

  test "sum downvotes returns proper result" do
    assert_equal 2, @restaurant.sum_downvotes
  end

end
