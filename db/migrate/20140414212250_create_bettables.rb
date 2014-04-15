class CreateBettables < ActiveRecord::Migration
  def change
    create_table :bettables do |t|
      t.integer :user_id
      t.integer :round_id

      t.timestamps
    end
  end
end
