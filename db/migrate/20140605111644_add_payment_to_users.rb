class AddPaymentToUsers < ActiveRecord::Migration
  def change
    add_column :users, :payment, :boolean
  end
end
