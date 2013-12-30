class AddIndexSomeModel < ActiveRecord::Migration
  def up
  	add_index :purchase_order_details, :purchase_order_id
  	add_index :purchase_order_details, :item_id
  	add_index :purchase_orders, :supplier_id
  	add_index :purchase_orders, :user_id
  	add_index :sales_invoice_details, :sales_invoice_id
  end

  def down
  	remove_index :purchase_order_details, :purchase_order_id
  	remove_index :purchase_order_details, :item_id
  	remove_index :purchase_orders, :supplier_id
  	remove_index :purchase_orders, :user_id
  	remove_index :sales_invoice_details, :sales_invoice_id
  end
end
