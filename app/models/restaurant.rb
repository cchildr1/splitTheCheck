class Restaurant < ApplicationRecord
  validates :name, presence: true
  validates :streetaddress, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zipcode, presence: true, format: { with: /\d{5}/, message: "Zip Code must contain 5 numbers" }

  has_many :votes
  has_many :comments

  def sum_votes
    votes = self.votes
    value = 0
    votes.each do |vote|
      value += vote.value
    end
    return value
  end

  def sum_upvotes
    value = 0
    self.votes.each do |vote|
      if vote.value == 1
        value += 1
        end
    end
    value
  end

  def sum_downvotes
    value = 0
    self.votes.each do |vote|
      if vote.value == -1
        value += 1
      end
    end
    value
  end

  def self.search(parameter)
    if parameter
      parameter = "%" + parameter + "%"
      where("lower(name) LIKE :search OR lower(state) LIKE :search OR lower(city) LIKE :search OR lower(zipcode) LIKE :search", search: parameter)
    else
      all
    end
  end
end
