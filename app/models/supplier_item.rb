class SupplierItem < ActiveRecord::Base
  attr_accessible :supplier_id, :item_id, :item_code, :item_category_name, :item_name, :stock, :date_price,
    :price, :next_price, :supplier_item_prices_attributes

  attr_accessor :item_code, :item_category_name, :item_name, :ppn

  belongs_to :supplier
  belongs_to :item

  has_many :supplier_item_prices

  accepts_nested_attributes_for :supplier_item_prices, :allow_destroy => true, :reject_if => :all_blank

  delegate :code, :name, :stock, :to => :item, :prefix => true

  after_save :update_stock_item, :insert_item_price

  def update_stock_item(default=self.item_stock)
    default = default ? default : 0
    stock = self.stock ? self.stock : 0
    item_stock = default + self.stock
    self.item.update_attributes(:stock => item_stock)
  end

  def min_stock(default = 0)
    stock = self.stock ? self.stock : 0
    item_stock = self.stock - default
    self.update_attributes(:stock => item_stock)
  end

  private

    def insert_item_price
      item_price = {
        :date_price => self.date_price, :price => self.price, :next_price => self.next_price, :item_id => self.item_id
      }
      self.supplier_item_prices.build(item_price).save
    end

end