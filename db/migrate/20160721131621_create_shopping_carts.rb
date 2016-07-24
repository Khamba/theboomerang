class CreateShoppingCarts < ActiveRecord::Migration
  def change
    create_table :shopping_carts do |t|
      t.references :owner, polymorphic: true
      # t.references :profile
      t.timestamps null: false
    end
  end
end
