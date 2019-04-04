class Vote < ApplicationRecord
  belongs_to :restaurant
  belongs_to :user
  validates_numericality_of :value, less_than_or_equal_to: 1, greater_than_or_equal_to: -1, not_equal_to: 0
end
