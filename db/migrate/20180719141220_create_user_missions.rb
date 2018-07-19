class CreateUserMissions < ActiveRecord::Migration[5.2]
  def change
    create_table :user_missions do |t|
      t.references :user
      t.integer :mission_id
      t.string :mission_type
      t.boolean :completed, null: false, default: false
      t.integer :progress, null: false, default: 0

      t.timestamps
    end
  end
end
