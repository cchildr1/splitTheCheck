class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @comment = @restaurant.comment(params[:comment][:user_id], params[:comment][:content])
    redirect_to restaurant_path(@restaurant)
  end
end