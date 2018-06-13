class AddStoneToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :stone, :integer, default: 0
  end
end
