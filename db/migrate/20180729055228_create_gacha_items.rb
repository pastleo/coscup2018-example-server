class CreateGachaItems < ActiveRecord::Migration[5.2]
  def change
    create_table :gacha_items do |t|
      t.references :rewardable, polymorphic: true, index: true
      t.references :gacha_group, foreign_key: true
      t.integer :weight, default: 1
      t.integer :amount, default: 1

      t.timestamps
    end
  end
end
