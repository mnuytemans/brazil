class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user, only: [:destroy, :payed]
  before_action :open, only: [:create]

  def index
    @users = User.all
  end

  def show
    if open?
      @user = current_user
    else
      @user = User.find(params[:id])
    end
      @games = Game.all
      @betstatus = @user.bet_status
      @bettables = @user.bettables
  end

  def New
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
      if User.count == 1 
        @user.toggle!(:admin)
      end
      sign_in @user
  		flash[:success] = "Welkom!"
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

  def payed
    @user = User.find(params[:id])
    if @user.update_attribute(:payment, params[:payed])
      render text: 'Betaling geregistreerd.', content_type: 'text/plain', status: 200 
    else
      render text: 'Fout bij het registreren van de betaling.', content_type: 'text/plain', status: 500
    end
    
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

  def open
    redirect_to(root_url) unless open?
  end

end
