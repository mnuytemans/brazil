class AddGroupToCountries < ActiveRecord::Migration
  def change
    add_column :countries, :group, :string
  end
end
