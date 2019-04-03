class Upvote < ApplicationRecord
  belongs_to :restaurant
  belongs_to :user
  validates_numericality_of :value, equal_to: 1
end
