class MixItem < ActiveRecord::Base
  attr_accessible :name, :item_second, :item_first, :item_second_value, :item_first_value, :stock

  belongs_to :category
  
  before_save :master_stok

  private
    def master_stok
      item_a = Item.find(item_first)
      stock = item_a.stock - self.item_first_value
      item_a.update_attributes(stock: stock)

      item_b = Item.find(item_first)
      stockb = item_b.stock - self.item_second_value
      item_b.update_attributes(stock: stockb)
    end
end