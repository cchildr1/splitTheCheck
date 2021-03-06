class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.integer :value
      t.belongs_to :restaurant, foreign_key: true
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
