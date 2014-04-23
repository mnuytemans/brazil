class TablesController < ApplicationController
  before_action :admin_user, only: [:index, :edit, :update]

  def new
  	if params[:id]
  		@round = Round.find(params[:id])
  		@countries = Country.all
  		if Table.find_by(round: @round)
  			@table = Table.find_by(round: @round)
  			render 'edit'
  		else
	  		@table = Table.new(round: @round)
	  		render 'new'
	  	end
  	else
  		redirect_to root_url
  	end
  end

  def create
  	@table = Table.new(table_params)
  	@table.country_ids = params[:tables][:country_ids].values
  	@countries = Country.all
  	if @table.save
  		flash[:success] = "Results added"
    	redirect_to current_user
  	else
  		render 'new'
  	end

  end

  def update
  	@table = Table.find_by(table_params)
  	@table.country_ids = params[:tables][:country_ids].values
  	if @table.save
  		flash[:success] = "Results added"
    	redirect_to current_user
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

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

  def table_params
  	params.require(:table).permit(:round_id, :countries)
  end


end
