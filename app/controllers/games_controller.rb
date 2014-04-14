class GamesController < ApplicationController
  before_action :admin_user, only: [:index, :create, :new]


  def index
  	@games = Game.all
  	@game = Game.new
  end

  def create
  	@game = Game.new(game_params)
  	if @game.save
  		redirect_to games_path
  	else
  		redirect_to games_path
  	end
  end

  def new
  	@game = Game.new
  end

  def show
    @games = Game.all
  end

  def update
    @game = Game.find(params[:id])
    if @game.update_attributes(game_params)
      flash[:success] = "Profile updated"
      redirect_to 'games#show'
    else
      render 'show'
    end
  end

  private
  	def game_params
  		params.require(:game).permit(:homeside, :awayside, :playdate, :group, :homescore, :awayscore)
  	end

  	def admin_user	
  		redirect_to(root_url) unless current_user.admin?
  	end

end
