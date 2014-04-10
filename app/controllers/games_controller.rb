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

  private
  	def game_params
  		params.require(:game).permit(:homeside, :awayside, :playdate, :group)
  	end

  	def admin_user	
  		redirect_to(root_url) unless current_user.admin?
  	end

end
