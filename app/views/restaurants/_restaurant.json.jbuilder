json.extract! restaurant, :id, :name, :streetaddress, :city, :state, :zipcode, :upvotes, :downvotes, :created_at, :updated_at
json.url restaurant_url(restaurant, format: :json)
