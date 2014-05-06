class Betjoker < ActiveRecord::Base
	belongs_to :user
	belongs_to :country
	belongs_to :round

	def set_score(score)
		self.update_attributes(score: score)
		self.update_attributes(scored: true)
	end
end
