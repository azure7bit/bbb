class PurchaseOrderDetail < ActiveRecord::Base
  attr_accessible :item_id, :qty, :price, :notes, :subtotal, :ppn, :total
  
  belongs_to :purchase_order
  belongs_to :item

  delegate :name, to: :item, :prefix => true

  validates :item_id, :presence => true
  validates :qty, presence: true
  validates :price, presence: true

  def has_ppn(supplier_id)
    item_ppn = self.item.supplier_items.find_by_supplier_id(supplier_id)
    item_ppn.is_ppn? ? "#{self.price}++" : self.price
  end

end