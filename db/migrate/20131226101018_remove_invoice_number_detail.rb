class RemoveInvoiceNumberDetail < ActiveRecord::Migration
  def up
  	remove_column :sales_invoice_details, :invoice_number
  	add_column :sales_invoice_details, :sales_invoice_id, :integer, :after => :id
  end

  def down
  	remove_column :sales_invoice_details, :invoice_number
  	add_column :sales_invoice_details, :sales_invoice_id, :integer, :after => :id
  end
end
