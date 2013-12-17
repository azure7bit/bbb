class SupplierItem < ActiveRecord::Base
  attr_accessible :purchase_price

  belongs_to :supplier
  belongs_to :item

  delegate :code, :name, :stock, :to => :item, :prefix => true
end