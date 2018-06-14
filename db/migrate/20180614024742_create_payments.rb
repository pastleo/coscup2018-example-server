class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.references :user, foreign_key: true
      t.integer :store, null: false

      t.string :product_id, null: false
      t.string :transaction_id, null: false
      t.text :receipt, null: false
      t.datetime :purchased_at, null: false

      t.string :currency, null: false
      t.integer :price, null: false
      t.integer :quantity, null: false

      t.boolean :valid, null: false, default: false
      t.boolean :checked, null: false, default: false

      t.timestamps
    end

    add_index :payments, :transaction_id, unique: true
    add_index :payments, [:user_id, :valid, :purchased_at], name: 'payment_orders'
  end
end
