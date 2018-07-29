class CreateGachas < ActiveRecord::Migration[5.2]
  def change
    create_table :gachas do |t|
      t.string :name
      t.boolean :opened, null: false, default: false

      t.timestamps
    end
  end
end
