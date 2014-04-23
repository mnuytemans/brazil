class BetjokersController < ApplicationController
	before_action :signed_in_user, only: [:new, :create, :edit, :update]
  	before_action :correct_user, only: [:edit, :update]
  	before_action :duplicate_joker, only: [:new, :create]
  	before_action :bettables_completed, only: [:new, :create]

	def new
		@bettables = current_user.bettables
		@betjoker = Betjoker.new(user: current_user)
	end

	def create
		@betjoker = Betjoker.new(betjoker_params)
		if @betjoker.save
  			flash[:success] = "Your joker was correctly saved"
  			redirect_to @current_user
  		else
      		render 'new'
  		end
	end

	def bettables_completed
	  redirect_to(root_url) unless current_user.bet_status["Bettable Status"]
	end

	def duplicate_joker
      redirect_to(root_url) unless current_user.betjoker.nil?
  	end

  	def correct_user
      @betjoker = Betjoker.find(params[:id])
      @user = @betjoker.user
      redirect_to(root_url) unless current_user?(@user)
    end

    def signed_in_user
	    unless signed_in?
	      store_location
	      redirect_to signin_url, notice: "Please sign in."
	    end
  	end

  	def betjoker_params
    	params.require(:betjoker).permit(:user_id,:round_id, :country_id)
  	end

end
