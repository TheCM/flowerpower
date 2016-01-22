class Product < ActiveRecord::Base
  has_many :order_items, dependent: :destroy
  validates :name, presence: true,
            length: { minumum: 2, maximum: 30}
  validates :price, presence: true
  validates :description, presence: true
end
