class AddIndexToBetset < ActiveRecord::Migration
  def change
  	add_index :betsets, :user_id, unique: true
  end
end
