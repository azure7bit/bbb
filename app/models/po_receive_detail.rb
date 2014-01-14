class PoReceiveDetail < ActiveRecord::Base
  attr_accessible :po_receive_id, :qty, :price, :subtotal, :item_id

  belongs_to :po_receive
  has_many :items

  def self.total_purchase_orders
    sum(:subtotal)
  end
  
end
