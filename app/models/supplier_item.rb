class SupplierItem < ActiveRecord::Base
  attr_accessible :supplier_id, :item_id, :item_code, :item_category_name, :item_name, :stock
  
  attr_accessor :item_code, :item_category_name, :item_name, :ppn
  
  belongs_to :supplier
  belongs_to :item

  has_many :supplier_item_prices

  delegate :code, :name, :stock, :to => :item, :prefix => true

  before_save :update_stock_item

  def price
    self.supplier_item_prices.any? ? self.supplier_item_prices.last.price : 0
  end

  private
    def update_stock_item
      item_stock = self.item_stock + self.stock
      self.item.update_attributes(:stock => item_name)
    end

end