class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @comment = @restaurant.comments.create(params[:comment].permit(:content, :user_id))
    redirect_to restaurant_path(@restaurant)
  end
end