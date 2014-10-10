class CreateSalesInvoices < ActiveRecord::Migration
  def change
    create_table :sales_invoices do |t|
      t.string :invoice_number
      t.integer :customer_id
      t.datetime :transaction_date
      t.string :payment
      t.string :npwp
      t.decimal :ppn, :precision => 12, :scale => 6
      t.integer :user_id
      t.timestamps
    end
  end
end
