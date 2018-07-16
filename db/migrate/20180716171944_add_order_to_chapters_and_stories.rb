class AddOrderToChaptersAndStories < ActiveRecord::Migration[5.2]
  def change
    add_column :chapters, :order, :integer, null: false, default: 0
    add_column :stories, :order, :integer, null: false, default: 0
  end
end
