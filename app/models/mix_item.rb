class MixItem < ActiveRecord::Base
  attr_accessible :item_id, :qty, :current_id, :item_name

  belongs_to :item
  after_create :master_stok

  attr_accessor :item_name

  def name
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
          supplier = Supplier.where(contact_person: "3B").first
          if supplier.present?
            item_for_supplier = {item_id: self.id, supplier_id: supplier.id, stock: self.stock}
            if supplier.supplier_items.build(item_for_supplier).save
              supplier.supplier_items.each do|sp|
                sp.update_mix_item
              end
            end
          else
            supplier = Supplier.create!({
              :code => Supplier.find_next_available_number_for,
              :first_name=>"Bandung",
              :last_name=>"3B",
              :address=>"123 10th Street",
              :city=>"Bandung",
              :contact_person => "3B",
              :phone_number=>"5550100" })
            data_supplier = {
              supplier_id: supplier.id,
              stock: mix_stock
            }
            if self.item.supplier_items.build(data_supplier).save
              supplier.supplier_items.each do|sp|
                sp.update_mix_item
              end
            end
          end
        end
      end
    end
end