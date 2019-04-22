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
    @user = users(:one)
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

  test "upvote adds a positive vote" do
    assert_difference "Vote.count" do
      @restaurant.upvote(@user.id)
    end
  end

  test "downvote adds a vote" do
    assert_difference "Vote.count" do
      @restaurant.downvote(@user.id)
    end
  end

  test "comment adds a comment" do
    assert_difference "Comment.count" do
      @restaurant.comment(@user.id, "comment")
    end
  end

end
