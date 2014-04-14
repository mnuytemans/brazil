class AddBetsetToUserBet < ActiveRecord::Migration
  def change
  	remove_index :bets, [:user_id, :game_id]
  	rename_column :bets, :user_id, :betset_id
  	add_index :bets, [:betset_id, :game_id], unique: true
  end
end
