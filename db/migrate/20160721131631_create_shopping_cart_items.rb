class CreateShoppingCartItems < ActiveRecord::Migration
  def change
    create_table :shopping_cart_items do |t|
      t.references :product
      t.references :shopping_cart
      t.date :delivery_date
      t.string :delivery_time
      t.string :size, null: false
      t.integer :price, null: false
      t.timestamps null: false
    end
  end
end
