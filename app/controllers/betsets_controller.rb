class BetsetsController < ApplicationController
  before_action :signed_in_user, only: [:new, :create, :edit, :update]
  before_action :duplicate_betset, only: [:new]
  before_action :correct_user, only: [:edit, :update, :show]


  def new
  	@user = current_user
    @betset = Betset.new(user: @user)
  	Game.all.each do |game|
  		@betset.bets.new(game: game)
  	end
  end

  def create
    @betset = Betset.new(betset_params)
    @betset.update_attributes(:bets_attributes => params[:betset][:bets_attributes])
  	if @betset.save
  		flash[:success] = "Pronostiek bewaard. Wijzigen nog steeds mogelijk."
  		redirect_to @current_user
  	else
      render 'new'
  	end
  end

  def show
    @betset = Betset.find(params[:id])
    @games = Game.all
  end

  def edit
    @betset = Betset.find(params[:id])
    @user = current_user
  end

  def update
    @betset = Betset.find(params[:id])
    @user = current_user
    if @betset.update_attributes(:bets_attributes => params[:betset][:bets_attributes])
      flash[:success] = "Pronostiek gewijzigd."
      redirect_to @user
    else
      render 'edit'
    end
  end



  private

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end

  def betset_params
    params.require(:betset).permit(:user_id,:bets_attributes)
  end

  def duplicate_betset
      redirect_to(root_url) unless current_user.betset.nil?
  end

  def correct_user
      @betset = Betset.find(params[:id])
      @user = @betset.user
      redirect_to(root_url) unless current_user?(@user)
  end

end
