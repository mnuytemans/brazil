class Bet < ActiveRecord::Base
	belongs_to :betset
	belongs_to :game
	validates :game_id, :homescore, :awayscore, presence: true

	def get_score
		{"homescore" => self.homescore, "awayscore" => self.awayscore}
	end

	def get_result
		if homescore == awayscore
			return "X"
		elsif homescore > awayscore
			return "1"
		else 
			return "2"
		end
		
	end

	def set_score(score)
		self.update_attributes(score: score)
		self.update_attributes(scored: true)
	end


end
