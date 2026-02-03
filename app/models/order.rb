class Order < ApplicationRecord
  has_many :order_items
  
  validates :address, presence: true
  validates :status, inclusion: { in: %w[pending delivered] }
end
