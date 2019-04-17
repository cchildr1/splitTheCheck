class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user


  def show
    @comments = @user.comments
    @votes = @user.votes
    @favorites = @user.favorites
  end

  private
  def set_user
    @user = User.find(params[:id])
  end
end
