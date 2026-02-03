class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy
  
  validates :address, presence: true
  validates :status, presence: true, inclusion: { in: %w[pending assigned out_for_delivery delivered] }
end
