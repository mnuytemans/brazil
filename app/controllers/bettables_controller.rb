class BettablesController < ApplicationController
  before_action :signed_in_user, only: [:new, :create, :edit, :update, :show]
  
  def New
    if current_user.next_bet_round
      @next_bet_round = Round.find_by(id: current_user.next_bet_round)
      @next_bet_countries = current_user.next_bet_countries
      @next_bettable = current_user.bettables.new(round_id: @next_bet_round.id)
    elsif !current_user.bet_status["Joker"]
      redirect_to new_betjoker_path
    else
      flash[:error] = "All rounds entered"
      redirect_to root_url
    end
  end

  def show
    @user = current_user
    @round = Round.find(params[:id])
    @bettable = Bettable.find_by(round_id: params[:id], user_id: current_user.id)
  end

  def edit
    if @next_bet_round = Round.find(params[:id])
      @next_bettable = Bettable.find_by(round_id: params[:id], user_id: current_user)
    	@next_bet_countries = current_user.bet_countries(params[:id])
      render 'New'
    else
      flash[:error] = "No Bettable found for this Round"
      redirect_to root_url
    end
  end

  def destroy
    current_user.bettables.destroy_all unless current_user.bettables.nil?
    current_user.betjoker.destroy unless current_user.betjoker.nil?
    redirect_to bettables_New_path
  end

  def create
     @bettable = current_user.bettables.new(bettable_params)
     @bettable.country_ids = params[:bettable][:country_ids].values
     if @bettable.save
      flash[:success] = "Bet for this round completed"
      redirect_to bettables_New_path
    else
      flash[:error] = "Bet failed"
      redirect_to bettables_New_path
  end

    
  end

  private

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end

  def bettable_params
    params.require(:bettable).permit(:user_id,:round_id, :country_ids)
  end


end
