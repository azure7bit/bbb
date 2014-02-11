class SupplierItem < ActiveRecord::Base
  attr_accessible :supplier_id, :item_id, :item_code, :item_category_name, :item_name, :stock, :date_price, 
    :price, :next_price, :supplier_item_prices_attributes, :item_date_price, :item_price, :item_next_price
  
  attr_accessor :item_code, :item_category_name, :item_name, :ppn, :date_price, :price, :next_price,
    :item_date_price, :item_price, :item_next_price
  
  belongs_to :supplier
  belongs_to :item

  has_many :supplier_item_prices

  accepts_nested_attributes_for :supplier_item_prices, :allow_destroy => true, :reject_if => :all_blank

  delegate :code, :name, :stock, :to => :item, :prefix => true

  after_save :update_stock_item, :insert_item_price

  def item_price
    self.supplier_item_prices.any? ? self.supplier_item_prices.last.price : 0
  end

  def item_next_price
    self.supplier_item_prices.any? ? self.supplier_item_prices.last.next_price : 0
  end

  def item_date_price
    self.supplier_item_prices.any? ? self.supplier_item_prices.last.date_price : 0
  end

  private
    def update_stock_item
      stock = self.stock ? self.stock : 0
      item_stock = self.item_stock + self.stock
      xx = self.item.update_attributes(:stock => item_stock)
    end

    def insert_item_price
      item_price = {
        :date_price => self.date_price, :price => self.price, :next_price => self.next_price, :item_id => self.item_id
      }
      self.supplier_item_prices.build(item_price).save
    end

end