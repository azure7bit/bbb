class SupplierItemPrice < ActiveRecord::Base
  attr_accessible :supplier_item_id, :date_price, :price, :next_price, :item_id

  belongs_to :supplier_item
end