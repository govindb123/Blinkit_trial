class Item < ApplicationRecord
  belongs_to :category, optional: true
  has_many :order_items, dependent: :destroy
  
  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
end
