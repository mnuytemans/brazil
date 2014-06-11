class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.integer :score
      t.integer :user_id

      t.timestamps
    end
    add_index :histories, :user_id
  end
end
