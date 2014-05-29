class Betset < ActiveRecord::Base
	belongs_to :user
	has_many :bets, dependent: :destroy
	has_many :games, :through => :bets
	accepts_nested_attributes_for :bets, :allow_destroy => true, :reject_if => :all_blank
	validates :user, presence: true
end
