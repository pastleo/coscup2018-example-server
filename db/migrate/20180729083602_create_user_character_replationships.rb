class CreateUserCharacterReplationships < ActiveRecord::Migration[5.2]
  def change
    create_table :user_character_replationships do |t|
      t.references :user, foreign_key: true
      t.references :character, foreign_key: true
      t.integer :favorability, null: false, default: 0

      t.timestamps
    end
  end
end
