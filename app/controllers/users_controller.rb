class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user, only: [:destroy]

  def index
    @users = User.all
  end

  def show
  	@user = User.find(params[:id])
    @games = Game.all
    @betstatus = @user.bet_status
  end

  def New
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
      sign_in @user
  		flash[:success] = "Welcome to the Sample App!"
  		redirect_to '/participate'
  	else
  		render 'New'
  	end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
      @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end


  private
  
  def user_params
  	params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end

  def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

end
