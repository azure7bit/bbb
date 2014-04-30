class CreateSupplierPayments < ActiveRecord::Migration
  def change
    create_table :supplier_payments do |t|
      t.datetime :transaction_date
      t.string :invoice_number
      t.integer :supplier_id
      t.string :notes
      t.string :balance_type
      t.float :amount
      t.integer :user_id
      t.timestamps
    end
  end
end