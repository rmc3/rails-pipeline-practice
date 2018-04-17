class SessionsController < ApplicationController
  def new() end

  def create
    user = User.find_by(username: params[:session][:username].downcase)
    if user&.authenticate(params[:session][:password])
      execute_login(user: user)
    else
      flash.now[:danger] = 'Invalid username/password combination'
      render 'new'
    end
  end

  def execute_login(user:)
    log_in user
    flash[:success] = "Successfully logged in as #{user.username}"
    redirect_to root_url
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
    flash.now[:success] = 'Logged out.'
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
