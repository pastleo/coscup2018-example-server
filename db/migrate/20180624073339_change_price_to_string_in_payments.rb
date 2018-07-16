class ChangePriceToStringInPayments < ActiveRecord::Migration[5.2]
  def change
    change_column :payments, :price, :string
  end
end
