class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.integer :rent_price
      t.integer :actual_price
      t.text :description

      t.timestamps null: false
    end
  end
end
