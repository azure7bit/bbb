class AddIndex < ActiveRecord::Migration
  def change
  	add_index :items, :category_id
  	add_index :sales_invoice_details, :item_id
  	add_index :sales_invoices, :customer_id
  	add_index :sales_invoices, :user_id
  	add_index :supplier_items, :supplier_id
  	add_index :supplier_items, :item_id
  end
end
