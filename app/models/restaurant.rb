class Restaurant < ApplicationRecord
  validates :name, presence: true
  validates :streetaddress, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zipcode, presence: true, format: { with: /\d{5}/, message: "Zip Code must contain 5 numbers" }

  has_many :votes

  def upvote

  end

  def downvote
    self.increment(:downvotes, 1)
  end
end
