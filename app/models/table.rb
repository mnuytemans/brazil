class Table < ActiveRecord::Base
	has_and_belongs_to_many :countries
	belongs_to :round
end
