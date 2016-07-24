# == Schema Information
#
# Table name: shopping_carts
#
#  id         :integer          not null, primary key
#  owner_id   :integer
#  owner_type :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ShoppingCart < ActiveRecord::Base
  has_many :shopping_cart_items, dependent: :destroy
  belongs_to :owner, polymorphic: true
  # belongs_to :profile

  def add_item(item, options = {})
    options[:delivery_date] = options[:delivery_date].to_date
    options[:price] = item.rent_price
    cart_item = shopping_cart_items.where(product: item).first_or_create
    cart_item.update_attributes(options)
    return cart_item
  end

  def remove_item(item)
    shopping_cart_items.find_by(product: item).destroy
  end

  def empty_cart
    shopping_cart_items.destroy_all
  end

  def total
    shopping_cart_items.sum(:price)
  end

  def item_count
    shopping_cart_items.count
  end

end
