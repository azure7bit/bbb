class CreateSupplierItems < ActiveRecord::Migration
  def change
    create_table :supplier_items do |t|
      t.integer :supplier_id
      t.integer :item_id
      t.float :purchase_price
    end
  end
end
