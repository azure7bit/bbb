class PurchaseOrderDetail < ActiveRecord::Base
  attr_accessible :item_id, :qty, :price, :notes, :subtotal, :ppn, :total
  
  belongs_to :purchase_order
  belongs_to :item

  delegate :name, to: :item, :prefix => true

  before_save :update_stock

  # after_save :total_purchase_statistic

  def self.total_purchase_orders
    sum(:subtotal)
  end

  def has_ppn(supplier_id)
    item_ppn = self.item.supplier_items.find_by_supplier_id(supplier_id)
    item_ppn.is_ppn? ? "#{self.price}++" : self.price
  end

  private

    def update_stock
      newStock = self.item.stock + self.qty
      self.item.update_attributes(:stock => newStock)
    end

    def total_purchase_statistic
      stat = Statistic.first
      total_purchase = stat.total_purchase.nil? ? 0 : (stat.total_purchase + PurchaseOrderDetail.total_purchase_orders)
      stat.update_attributes(:total_purchase => total_purchase)
    end

end