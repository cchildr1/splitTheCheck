class Restaurant < ApplicationRecord
  validates :name, presence: true
  validates :streetaddress, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zipcode, presence: true, format: { with: /\d{5}/, message: "Zip Code must contain 5 numbers" }
  validates_numericality_of :upvotes, only_integer: true, greater_than_or_equal_to:  0
  validates_numericality_of :downvotes, only_integer: true, greater_than_or_equal_to: 0
end
