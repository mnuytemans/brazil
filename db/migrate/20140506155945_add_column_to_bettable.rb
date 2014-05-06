class AddColumnToBettable < ActiveRecord::Migration
  def change
    add_column :bettables, :score, :integer
    add_column :bettables, :scored, :boolean
  end
end
