class Country < ActiveRecord::Base
	has_and_belongs_to_many :tables
	has_and_belongs_to_many :bettables
	has_many :betjoker
end
