class CreatePurchaseOrderDetails < ActiveRecord::Migration
  def change
    create_table :purchase_order_details do |t|
      t.integer :purchase_order_id
      t.integer :item_id
      t.integer :qty
      t.decimal :price, :precision => 30, :scale => 14
      t.string :notes
      t.integer :subtotal
      t.decimal :ppn, :precision => 30, :scale => 14
      t.decimal :total, :precision => 30, :scale => 14
      t.timestamps
    end
  end
end
