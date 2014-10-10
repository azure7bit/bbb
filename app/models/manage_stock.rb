class ManageStock < ActiveRecord::Base
  attr_accessible :item_id, :supplier_id, :items_out

  belongs_to :supplier
  belongs_to :item

  after_save :update_supplier_items

  def update_supplier_items
    item = SupplierItem.where(:item_id => self.item_id, :supplier_id => self.supplier_id).first
    item.min_stock(self.items_out)
  end
end