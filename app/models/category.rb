# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Category < ActiveRecord::Base

  has_many :product_categories
  has_many :products, through: :product_categories, dependent: :destroy

  validates_presence_of :name

end
