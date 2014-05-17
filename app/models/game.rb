class Game < ActiveRecord::Base
	after_update :calculate_score

	has_many :bets
	has_many :users, :through => :bets

	validates :homeside, presence: true
	validates :awayside, presence: true
	validates :playdate, presence: true
	validates :group, presence: true

	

	def calculate_score
		score_exact = Setting.find_by(name: "Exact Score").value
		score_correct = Setting.find_by(name: "Correct Score").value
		score_fail = Setting.find_by(name: "Incorrect Score").value


		if !self.homescore.nil? && !self.awayscore.nil?
			self.bets.each do |bet|
				betscore = bet.get_score
				betresult = betscore["homescore"] - betscore["awayscore"]
				gameresult = self.homescore - self.awayscore
				score = 0

				if betscore["homescore"] == self.homescore && betscore["awayscore"] == self.awayscore
					score = score_exact
				elsif  ( betresult == gameresult ) || ( betresult > 0 && gameresult > 0 ) || ( betresult < 0 && gameresult <0)
					score = score_correct
				else
					score = score_fail
				end
				bet.set_score(score)
				bet.betset.user.update_score
			end 
		end
	end

end
