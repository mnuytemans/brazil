class AddIndexToGameGroupDate < ActiveRecord::Migration
  def change
  	add_index :games, :playdate
  	add_index :games, :group
  end
end
