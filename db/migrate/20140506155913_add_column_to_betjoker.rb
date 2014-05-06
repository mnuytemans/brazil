class AddColumnToBetjoker < ActiveRecord::Migration
  def change
    add_column :betjokers, :score, :integer
    add_column :betjokers, :scored, :boolean
  end
end
