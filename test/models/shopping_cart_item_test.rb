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

require 'test_helper'

class ShoppingCartItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
