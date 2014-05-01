class Round < ActiveRecord::Base
	has_one :table
	has_many :tablebets
	has_many :betjokers
	default_scope -> { order ('teams DESC')}



  def next
    self.class.unscoped.where("teams <= ? AND id != ?", teams, id).order("teams DESC").first
  end

  def previous
    self.class.unscoped.where("teams >= ? AND id != ?", teams, id).order("teams ASC").first
  end


end
