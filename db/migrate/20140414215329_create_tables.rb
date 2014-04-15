class CreateTables < ActiveRecord::Migration
  def change
    create_table :tables do |t|
      t.integer :round_id
      t.timestamps
    end
  end
end
