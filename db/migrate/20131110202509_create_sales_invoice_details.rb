class CreateSalesInvoiceDetails < ActiveRecord::Migration
  def change
    create_table :sales_invoice_details do |t|
      t.string :invoice_number
      t.integer :item_id
      t.integer :qty
      t.float :subtotal
      t.timestamps
    end
  end
end
