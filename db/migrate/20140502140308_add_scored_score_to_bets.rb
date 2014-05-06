class AddScoredScoreToBets < ActiveRecord::Migration
  def change
    add_column :bets, :scored, :boolean
    add_column :bets, :score, :integer
  end
end
