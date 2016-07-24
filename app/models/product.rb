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

class Product < ActiveRecord::Base
  has_many :product_images, dependent: :destroy
  accepts_nested_attributes_for :product_images
  has_many :product_categories, dependent: :destroy
  accepts_nested_attributes_for :product_categories
  has_many :categories, through: :product_categories

  SUPERCATEGORIES = [ 'Western', 'Ethnic' ]
  SIZES = [ 'S', 'M', 'L', 'XL' ]

  validates_presence_of :name
  validates :rent_price, numericality: { greater_than: 0, integer: true }
  validates :actual_price, numericality: { greater_than: 0, integer: true }
  validates :supercategory, inclusion: { in: SUPERCATEGORIES }
  validate :at_least_one_size_is_available
  validate :valid_sizes_array
  validate :at_least_one_image

  private

    def at_least_one_size_is_available
      unless sizes.is_a?(Array) && sizes.length > 0
        errors.add(:sizes, 'at least one size must be available')
      end
    end

    def valid_sizes_array
      if sizes.detect{|s| !SIZES.include?(s)}
        errors.add(:sizes, :invalid)
      end
    end

    def at_least_one_image
      if self.product_images.empty?
        errors.add('product_images.base', 'at least one image must be present')
      end
    end
  
end
