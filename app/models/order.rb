class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy
  
  validates :address, presence: true
  validates :status, presence: true, inclusion: { in: %w[pending assigned picked_up in_transit nearby delivered] }
  
  before_update :set_status_updated_at, if: :status_changed?
  after_create :set_estimated_delivery_time
  
  def status_display
    case status
    when 'pending' then '⏳ Order Confirmed'
    when 'assigned' then '👤 Rider Assigned'
    when 'picked_up' then '📦 Picked Up'
    when 'in_transit' then '🚚 On the Way'
    when 'nearby' then '📍 Nearby (5 mins)'
    when 'delivered' then '✅ Delivered'
    end
  end
  
  def progress_percentage
    case status
    when 'pending' then 16
    when 'assigned' then 33
    when 'picked_up' then 50
    when 'in_transit' then 66
    when 'nearby' then 83
    when 'delivered' then 100
    else 0
    end
  end
  
  private
  
  def set_status_updated_at
    self.status_updated_at = Time.current
  end
  
  def set_estimated_delivery_time
    self.estimated_delivery_time = 30.minutes.from_now
  end
end
