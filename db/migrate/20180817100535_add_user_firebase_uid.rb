class AddUserFirebaseUid < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :firebase_uid, :string
  end
end
