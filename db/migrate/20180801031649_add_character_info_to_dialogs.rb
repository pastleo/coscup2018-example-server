class AddCharacterInfoToDialogs < ActiveRecord::Migration[5.2]
  def change
    add_reference :dialogs, :character, foreign_key: false
    add_column :dialogs, :character_expression, :integer, default: 0
  end
end
