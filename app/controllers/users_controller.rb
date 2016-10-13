class UsersController < ApplicationController
  before_action :is_authenticated, except: [:new, :create]
  before_action :is_authenticated_admin, only: [:index, :destroy, :toggle_admin]
  before_action :search
  # GET /register
  def new
    @user = User.new
  end

  # POST /register
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path, notice: 'Account Created. Please Login'
    else
      render :new
    end
  end


  # GET /profile
  def show
    @user = current_user
  end

  # GET /profile/edit
  def edit
    @user = current_user
  end

  # PATCH/PUT /profile
  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to root_path, notice: 'Profile was successfully updated.'
    else
      render :edit
    end
  end


  # GET /users
  def index
    @users = User.all
  end

  # DELETE /users/1
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  # PATCH/PUT  /users/1/admin
  def toggle_admin
    @user = User.find(params[:id])
    @user.is_admin = !@user.is_admin
    if @user.save
      redirect_to users_url, notice: "User #{@user.name} Admin status is: #{@user.is_admin?}"
    else
      redirect_to users_url, notice: "Error setting admin status: #{@user.errors.full_messages.first}"
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :family_name, :email, :password, :password_confirmation)
  end

end
