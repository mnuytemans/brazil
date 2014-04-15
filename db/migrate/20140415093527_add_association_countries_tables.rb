class AddAssociationCountriesTables < ActiveRecord::Migration
  def change
  	  create_table :countries_tables, id: false do |t|
      	t.belongs_to :country
      	t.belongs_to :table
  		end
  end
end
