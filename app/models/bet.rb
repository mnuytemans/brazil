class Bet < ActiveRecord::Base
	belongs_to :user
	belongs_to :game
	validates :user_id, :game_id, :homescore, :awayscore, presence: true

end
