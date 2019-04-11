require 'test_helper'

class VoteTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  setup do
    @vote = Vote.new(restaurant_id: restaurants(:two).id.to_i, user_id: users(:one).id.to_i)
  end
  test "create vote with value of 1 user and restaurant" do
    @vote.value = 1
    assert @vote.valid?
  end
  test "create vote with value of -1 with user and restaurant" do
    @vote.value = -1
    assert @vote.valid?
  end
  test "vote with value less than -1 is invalid" do
    @vote.value = -4
    assert_not @vote.valid?
  end

  test "vote with value greater than 1 is invalid" do
    @vote.value = 4
    assert_not @vote.valid?
  end
end
