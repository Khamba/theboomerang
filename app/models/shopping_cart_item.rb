# == Schema Information
#
# Table name: shopping_cart_items
#
#  id               :integer          not null, primary key
#  product_id       :integer
#  shopping_cart_id :integer
#  delivery_date    :date
#  delivery_time    :string
#  size             :string           not null
#  price            :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class ShoppingCartItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :shopping_cart

  validates_uniqueness_of :product, scope: :shopping_cart
  validates_inclusion_of :size, in: Product::SIZES, message: 'is invaid'
  validates :price, numericality: { greater_than: 0, integer: true }
  validates_presence_of :delivery_date
  validates_presence_of :delivery_time
end
