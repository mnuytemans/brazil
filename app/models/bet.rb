class Bet < ActiveRecord::Base
	belongs_to :betset
	belongs_to :game
	validates :game_id, :homescore, :awayscore, presence: true
end
