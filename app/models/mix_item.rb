class MixItem < ActiveRecord::Base
  attr_accessible :item_id, :qty, :current_id

  belongs_to :item
  before_save :master_stok

  def item_name
    current_item = Item.find(self.current_id)
    return current_item.name
  end

  private
    def master_stok
      current_item = Item.find(self.current_id)
      stock = current_item.stock - self.qty
      current_item.update_attributes(stock: stock)

      item_stock = self.item.stock ? self.item.stock : 0
      mix_stock = item_stock + self.qty
      self.item.update_attributes(stock: mix_stock)
    end
end
