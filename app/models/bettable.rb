class Bettable < ActiveRecord::Base
	belongs_to :user
	belongs_to :round
	has_and_belongs_to_many :countries

	validates_numericality_of :number_of_teams, equal_to: -> (bettable) { bettable.round.teams }

	def set_score(score)
		self.update_attributes(score: score)
		self.update_attributes(scored: true)
	end

	def number_of_teams
		return self.countries.size
	end
end
