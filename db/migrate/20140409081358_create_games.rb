class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :homeside
      t.string :awayside
      t.integer :homescore
      t.integer :awayscore
      t.date :playdate
      t.string :group

      t.timestamps
    end
  end
end
