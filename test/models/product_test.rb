# == Schema Information
#
# Table name: products
#
#  id            :integer          not null, primary key
#  name          :string
#  rent_price    :integer
#  actual_price  :integer
#  description   :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  supercategory :string
#  sizes         :string           default([]), is an Array
#

require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
