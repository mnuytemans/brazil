class Game < ActiveRecord::Base
	has_many :bets
	has_many :users, :through => :bets
	validates :homeside, presence: true
	validates :awayside, presence: true
	validates :playdate, presence: true
	validates :group, presence: true
end
