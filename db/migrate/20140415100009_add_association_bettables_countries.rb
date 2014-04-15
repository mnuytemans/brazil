class AddAssociationBettablesCountries < ActiveRecord::Migration
  def change
  	create_table :bettables_countries, id: false do |t|
  		t.belongs_to :bettable
  		t.belongs_to :country
  	end
  end
end
