class CreateBetjokers < ActiveRecord::Migration
  def change
    create_table :betjokers do |t|
      t.integer :user_id
      t.integer :country_id
      t.integer :round_id

      t.timestamps
    end
  end
end
