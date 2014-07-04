class CreatePoReceives < ActiveRecord::Migration
  def change
    create_table :po_receives do |t|
      t.integer :purchase_order_id
      t.string :invoice_number
      t.date :transaction_date
      t.string :status
      t.integer :user_id
      t.float :kurs
      t.float :ppn
      t.integer :supplier_id
      t.timestamps
    end
  end
end