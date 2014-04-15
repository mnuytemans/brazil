class Round < ActiveRecord::Base
	has_one :table
	has_many :tablebets
	has_many :betjokers
end
