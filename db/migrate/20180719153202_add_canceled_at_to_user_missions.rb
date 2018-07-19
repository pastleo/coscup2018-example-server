class AddCanceledAtToUserMissions < ActiveRecord::Migration[5.2]
  def change
    add_column :user_missions, :canceled_at, :datetime
  end
end
