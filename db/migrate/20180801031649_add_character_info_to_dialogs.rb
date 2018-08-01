class AddCharacterInfoToDialogs < ActiveRecord::Migration[5.2]
  def change
    add_reference :dialogs, :characters, foreign_key: false
    add_column :dialogs, :character_expression, :integer
  end
end
