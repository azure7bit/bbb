class CreateCustomerPayments < ActiveRecord::Migration
  def change
    create_table :customer_payments do |t|
      t.datetime :transaction_date
      t.string :invoice_number
      t.integer :customer_id
      t.string :notes
      t.string :balance_type
      t.float :amount
      t.integer :user_id
      t.timestamps
    end
  end
end
