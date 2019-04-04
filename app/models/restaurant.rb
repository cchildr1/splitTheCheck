class Restaurant < ApplicationRecord
  validates :name, presence: true
  validates :streetaddress, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zipcode, presence: true, format: { with: /\d{5}/, message: "Zip Code must contain 5 numbers" }

  has_many :votes

  def sum_votes
    votes = self.votes
    value = 0
    votes.each do |vote|
      value += vote.value
    end
    return value
  end
end
