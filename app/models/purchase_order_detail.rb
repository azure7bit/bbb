class PurchaseOrderDetail < ActiveRecord::Base
  attr_accessible :item_id, :qty, :price, :notes, :subtotal, :ppn, :total
  
  belongs_to :purchase_order
  belongs_to :item

  before_save :update_stock

  # before_save :total_po_amount

  private

  #   def total_po_amount
  #     Statistic.total_amount_po(self.purchase_order_details.sum(:subtotal))
  #   end

    def update_stock
      newStock = self.item.stock + self.qty
      self.item.update_attributes(:stock => newStock)
    end

end