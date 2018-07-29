class CreateGachaGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :gacha_groups do |t|
      t.integer :weight, default: 1
      t.references :gacha, foreign_key: true

      t.timestamps
    end
  end
end
