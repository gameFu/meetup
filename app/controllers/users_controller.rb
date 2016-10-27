class UsersController < ApplicationController

  skip_before_action :logged_in_user

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_url
    else
      render 'new'
    end
  end

  def new
    @user = User.new
  end

  private
  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end

end
