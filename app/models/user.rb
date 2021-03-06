class User < ActiveRecord::Base
	


	has_one :betset, dependent: :destroy
	has_one :betjoker, dependent: :destroy
	has_many :bets, :through => :betset
	has_many :games, :through => :bets
	has_many :rounds, :through => :bettables
	has_many :bettables, dependent: :destroy
	has_many :histories, dependent: :destroy
	

	before_save { self.email = email.downcase }
	before_create :create_remember_token



	# Validations
	validates :name, presence: true, length: { maximum: 30 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
	validates :password, length: { minimum: 6 }

	has_secure_password

	def User.new_remember_token
		SecureRandom.urlsafe_base64
	end

	def User.hash(token)
		Digest::SHA1.hexdigest(token.to_s)
	end


	def send_password_reset 
		generate_token(:password_reset_token)
  		self.update_attribute(:password_reset_sent_at, Time.zone.now)
  		UserMailer.password_reset(self).deliver
	end


	# Returns the status on all the bets of the user
	def bet_status
		@betstatus = {"Completed" => true, "Betset" => true, "Bettable" => {}, "Bettable Status" => true, "Joker" => true}
		betrounds = Round.all.sort {|a,b| b.teams <=> a.teams}
					
		if betset.nil?
			@betstatus["Betset"] = false
			@betstatus["Completed"] = false
		end

		betrounds.each do |x|
			if !bettables.find_by(round_id: x.id).nil?
				@betstatus["Bettable"][x.id] = true
			else
				@betstatus["Bettable"][x.id] = false
				@betstatus["Completed"] = false
				@betstatus["Bettable Status"] = false
			end
		end

		# Descoped for Betjoker
		#if betjoker.nil?
		#	@betstatus["Joker"] = false
		#	@betstatus["Completed"] = false
		#end

		return @betstatus
	end

	# Method that returns the round_id of the next Bet round
	def next_bet_round
		if @betstatus.nil?
			self.bet_status
		end
		next_rounds = @betstatus["Bettable"].select{|key, value| value == false}
		return next_rounds.keys.first
	end

	# Method that returns the available countries for the next Bet round
	def next_bet_countries
		if @betstatus.nil?
			self.bet_status
		end
		
		previous_rounds = @betstatus["Bettable"].select{|key, value| value == true}
		
		if !previous_rounds.empty?
			last_round = previous_rounds.keys.last
			last_countries = bettables.find_by(round_id: last_round).countries
		else
			last_countries = Country.all
		end

		return last_countries
	end

	def bet_countries(round)
		if @betstatus.nil?
			self.bet_status
		end
		previous_bet_round_index = @betstatus["Bettable"].keys.index(round.to_i) -1
		if previous_bet_round_index > 0 
			last_round = @betstatus["Bettable"].keys[previous_bet_round_index]
			last_countries = bettables.find_by(round_id: last_round).countries.to_a
		else
			last_countries = Country.all
		end
		return last_countries
	end

	def update_score
		score = 0
		if @betstatus.nil?
			self.bet_status
		end
		if @betstatus["Completed"]
			
			self.bets.where(scored: true).all.each do |bet|
				score += bet.score
			end
			self.bettables.where(scored:true).all.each do |bettable|
				score += bettable.score
			end
			if self.betjoker
				if self.betjoker.scored
					score += self.betjoker.score
				end
			end
		end
		self.update_attribute(:score, score.to_i)
		self.histories.create(score: score.to_i)
	end

	def get_score
		return self.score
	end


	private
		def create_remember_token
			self.remember_token = User.hash(User.new_remember_token)
		end

		def generate_token(column)
				self.update_attribute(column, User.new_remember_token)
		end

		def password_required?
    		# Validation required if this is a new record or the password is being updated.
    		self.new_record? or self.password?
  		end
end
