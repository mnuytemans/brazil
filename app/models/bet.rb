class Bet < ActiveRecord::Base
	belongs_to :betset
	belongs_to :game
	validates :game_id, :homescore, :awayscore, presence: true

	def get_score
		{"homescore" => self.homescore, "awayscore" => self.awayscore}
	end

	def set_score(score)
		self.update_attributes(score: score)
		self.update_attributes(scored: true)
	end


end
