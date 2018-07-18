class CreateDialogs < ActiveRecord::Migration[5.2]
  def change
    create_table :dialogs do |t|
      t.text :script
      t.string :mission_type
      t.integer :mission_id
      t.integer :order, null: false, default: 0

      t.timestamps
    end
  end
end
