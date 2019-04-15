# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
require 'csv'
Restaurant.delete_all
csv_text = File.read(Rails.root.join('lib', 'data', 'restaurants.csv'))
csv = CSV.parse(csv_text, :headers => true)
csv.each do |row|
  Restaurant.create!(row.to_hash)
end

User.delete_all
csv_text = File.read(Rails.root.join('lib', 'data', 'users.csv'))
csv = CSV.parse(csv_text, :headers => true)
csv.each do |row|
  user = User.new
  user.email = row.to_hash["email"]
  user.password = 'valid_password'
  user.save!
end

def randomvalue
  value = rand(100)
  if value >= 50
    return 1
  else
    return -1
  end
end

Vote.delete_all
500.times do
  Vote.create(value: randomvalue, restaurant_id: rand(Restaurant.all.size), user_id: rand(User.all.size))
end

Comment.delete_all
csv_text = File.read(Rails.root.join('lib', 'data', 'comments.csv'))
csv = CSV.parse(csv_text, :headers => true)
csv.each do |row|
  comment = Comment.new
  comment.content = row.to_hash["content"]
  comment.user_id = rand(User.all.size)
  comment.restaurant = rand(Restaurant.all.size)
  comment.save!
end



