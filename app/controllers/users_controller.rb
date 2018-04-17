class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'Successfully signed up. Log in with your new user.'
      redirect_to login_url
    else
      render 'new'
    end
  end

  def logout
    @user = nil
    flash[:success] = 'Logged out.'
    redirect_to root_url
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
end
