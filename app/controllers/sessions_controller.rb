class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.authenticate(user_params)

    if user
      session[:user_id] = user.id
      flash[:notice] = "User Logged In!"
      redirect_to root_path
    else
      flash[:notice] = "Credentials Invalid!"
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "User logged out!"
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

end
