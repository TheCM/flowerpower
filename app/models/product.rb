class Product < ActiveRecord::Base
  mount_uploader :image, FlowerPictureUploader
  has_many :order_items
  validates :name, presence: true,
            length: { minumum: 2, maximum: 30}
  validates :price, presence: true
  validates :description, presence: true
end
