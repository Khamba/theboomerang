# == Schema Information
#
# Table name: product_images
#
#  id         :integer          not null, primary key
#  product_id :integer
#  image      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_product_images_on_product_id  (product_id)
#
# Foreign Keys
#
#  fk_rails_1c991d3be6  (product_id => products.id)
#

class ProductImage < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  belongs_to :product
  validates_presence_of :image
  validate :correct_format, if: :image?, :on => :create
  validate :file_size, on: :create

  private

    def correct_format
      ext = File.extname(self.image.filename)
      if !%w( .jpg .jpeg .png ).include?(ext.downcase) 
        errors[:base] << "Invalid file format."
      end
    end

    def file_size
      if image.nil? and image.file.size.to_f/(1000*1000) > 7.to_f
        errors.add(:base, "You cannot upload a file greater than 7 MB")
      end
    end

end
