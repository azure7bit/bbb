class PurchaseOrderDetail < ActiveRecord::Base
  attr_accessible :item_id, :qty, :price, :notes, :subtotal, :ppn, :total
  
  belongs_to :purchase_order
  belongs_to :item

  # before_save :total_po_amount

  # private

  #   def total_po_amount
  #     Statistic.total_amount_po(self.purchase_order_details.sum(:subtotal))
  #   end
end