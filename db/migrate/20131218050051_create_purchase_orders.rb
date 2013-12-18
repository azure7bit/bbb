class CreatePurchaseOrders < ActiveRecord::Migration
  def change
    create_table :purchase_orders do |t|
      t.string :po_number
      t.datetime :transaction_date
      t.datetime :po_date
      t.string :spph_number
      t.datetime :spph_date
      t.integer :supplier_id
      t.datetime :deadline
      t.integer :term_of_payment
      t.text :remarks
      t.string :status
      t.string :po_type
      t.integer :user_id
      t.timestamps
    end
  end
end
