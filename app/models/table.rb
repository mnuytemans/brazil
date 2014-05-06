class Table < ActiveRecord::Base
	after_save :calculate_score
	has_and_belongs_to_many :countries
	belongs_to :round



	def calculate_score
		# Fetch all the bettables for this round
		bettables = Bettable.where(:round_id => self.round.id).all
		round_score = Setting.find_by(name: self.round.name).value

		# Loop over bettables
		bettables.each do |bettable|
			score = 0
			# Loop over countries in round and check if in bettable
			self.countries.each do |country|
				# If country is in bettable, add score to bettable
				if bettable.countries.exists?(country.id)
					score += round_score
				end
			end
			# Set score of the bettable as the sum of all scores of each country in the bettable
			bettable.set_score(score)
		end

		# Loop over betjokers
		if Betjoker.exists?(round_id: self.round.id, country_id: self.countries)
			Betjoker.where(:round_id => self.round.id, :country_id => self.countries).all.each do |betjoker|
				if self.countries.exists?(betjoker.country.id)
					betjoker.set_score(round_score)
				else
					betjoker.set_score(0)
				end
			end
		end



		

	end
end
