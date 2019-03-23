require 'test_helper'

class RestaurantTest < ActiveSupport::TestCase

  setup do
    @test = Restaurant.new
    @test.name = "name"
    @test.streetaddress = "123 street street"
    @test.city = "town"
    @test.state = "GA"
    @test.zipcode = "31257"
    @test.upvotes = 1
    @test.downvotes = 3
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

  test "upvotes cannot be negative" do
    @test.upvotes = -3
    assert_not @test.valid?
    assert_equal [:upvotes], @test.errors.keys
  end

  test "upvotes must be an integer" do
    @test.upvotes = 1.5
    assert_not @test.valid?
    assert_equal [:upvotes], @test.errors.keys
  end

  test "downvotes cannot be negative" do
    @test.downvotes = -3
    assert_not @test.valid?
    assert_equal [:downvotes], @test.errors.keys
  end

  test "downvotes must be an integer" do
    @test.downvotes = 1.5
    assert_not @test.valid?
    assert_equal [:downvotes], @test.errors.keys
  end

  test "upvote increments upvotes by 1" do
    value = @test.upvotes
    @test.upvote
    assert_equal @test.upvotes, value + 1
  end

  test "downvote increments downvotes by 1" do
    value = @test.downvotes
    @test.downvote
    assert_equal @test.downvotes, value + 1
  end

end
