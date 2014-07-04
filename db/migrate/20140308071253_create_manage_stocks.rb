class CreateManageStocks < ActiveRecord::Migration
  def change
    create_table :manage_stocks do |t|
      t.integer :item_id
      t.integer :supplier_id
      t.integer :items_out
      t.timestamps
    end

    add_column :sales_invoice_details, :stock_updated, :boolean, :default => false
  end
end
