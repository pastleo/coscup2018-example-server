class AddUsernameToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :username, :string, null: false
    add_index :users, :username, unique: true

    # Prevent email is required and unique
    change_column :users, :email, :string, null: true
    remove_index :users, :email
  end
end
