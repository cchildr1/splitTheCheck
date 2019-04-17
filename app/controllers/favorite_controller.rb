class FavoriteController < ApplicationController
  before_action :set_restaurant

  def create
    if Favorite.create(restaurant_id: @restaurant.id, user: current_user)
      redirect_to @restaurant, notice: 'Restaurant has been favorited'
    else
      redirect_to @restaurant, alert: "Something is wrong"
    end
  end

  def destroy
    Favorite.where(user_id: params[:user_id], restaurant_id: params[:restaurant_id]).first.destroy
    redirect_to @restaurant, notice: "Restaurant no longer in favorites"
  end

  private
  def set_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id] || params[:format])
  end
end
