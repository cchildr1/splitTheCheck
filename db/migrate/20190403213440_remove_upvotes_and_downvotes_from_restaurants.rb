class RemoveUpvotesAndDownvotesFromRestaurants < ActiveRecord::Migration[5.2]
  def change
    remove_column :restaurants, :upvotes, :integer
    remove_column :restaurants, :downvotes, :integer
  end
end
