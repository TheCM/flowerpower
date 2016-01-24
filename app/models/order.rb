class Order < ActiveRecord::Base
  has_many :order_items
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :address, presence: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
end
