class SupplierItem < ActiveRecord::Base
  attr_accessible :supplier_id, :item_id, :item_code, :item_category_name, :item_name, :stock, :date_price, :price, :next_price
  # attr_accessible :supplier_item_prices_attributes
  
  attr_accessor :item_code, :item_category_name, :item_name, :ppn
  
  belongs_to :supplier
  belongs_to :item

  has_many :supplier_item_prices

  # accepts_nested_attributes_for :supplier_item_prices, :allow_destroy => true, :reject_if => :all_blank

  delegate :code, :name, :stock, :to => :item, :prefix => true

  after_save :update_stock_item

  # def price
  #   self.supplier_item_prices.any? ? self.supplier_item_prices.last.price : 0
  # end

  private
    def update_stock_item
      item_stock = self.item_stock + self.stock
      xx = self.item.update_attributes(:stock => item_stock)
    end

end