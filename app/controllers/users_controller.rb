class UsersController < ApplicationController
  before_filter :authenticate_user!

  #TODO remove index action not just from controller, but also from routes
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to :back, :alert => "Access denied."
    end
  end

end
