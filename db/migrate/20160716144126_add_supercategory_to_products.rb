class AddSupercategoryToProducts < ActiveRecord::Migration
  def change
    add_column :products, :supercategory, :string
    add_column :products, :sizes, :string, array: true, default: []
  end
end
