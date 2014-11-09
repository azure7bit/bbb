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
      if self.item.update_attributes(stock: mix_stock)
        unless self.item.supplier_items
          supplier = Supplier.create!({:first_name=>"Warna", :last_name=>"Jaya", :address=>"123 10th Street", :city=>"Bandung", :phone_number=>"5550100" })
          data_supplier = {
            supplier_id: supplier.id,
            stock: mix_stock
          }
          self.item.supplier_items.build(data_supplier).save
        end
      end
    end
end