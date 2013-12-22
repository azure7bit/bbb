class SupplierItem < ActiveRecord::Base
  attr_accessible :purchase_price, :supplier_id, :item_id, :item_code, :item_category_name, :item_name
  
  attr_accessor :item_code, :item_category_name, :item_name
  
  belongs_to :supplier
  belongs_to :item

  delegate :code, :name, :stock, :to => :item, :prefix => true
end