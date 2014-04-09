class CreateBets < ActiveRecord::Migration
  def change
    create_table :bets do |t|
      t.integer :homescore
      t.integer :awayscore
      t.integer :user_id
      t.integer :game_id

      t.timestamps
    end
    add_index :bets, [:user_id, :game_id], unique: true
  end
end
