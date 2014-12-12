class AddTypeCurrency < ActiveRecord::Migration
  def up
  	add_column :purchase_orders, :currency_type, :boolean, default: :false
    add_column :po_receives, :currency_type, :boolean, default: :false
    add_column :sales_invoices, :currency_type, :boolean, default: :false
  end

  def down
  	ActiveRecord::IrreversibleMigration
  end
end
