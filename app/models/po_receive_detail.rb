class PoReceiveDetail < ActiveRecord::Base
  attr_accessible :po_receive_id, :qty, :price, :subtotal, :item_id, :name, :valas

  attr_accessor :name, :valas

  belongs_to :po_receive
  belongs_to :item

  delegate :name, to: :item, :prefix => true

  def self.total_purchase_orders
    sum(:subtotal)
  end
  
  def update_stock
    newStock = self.item.stock + self.qty
    self.item.update_attributes(:stock => newStock)
  end
end
