class Betjoker < ActiveRecord::Base
	belongs_to :user
	belongs_to :country
	belongs_to :round
end
