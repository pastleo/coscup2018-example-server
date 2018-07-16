class ChangeValidToVerifiedInPayments < ActiveRecord::Migration[5.2]
  def change
    rename_column :payments, :valid, :verified
  end
end
