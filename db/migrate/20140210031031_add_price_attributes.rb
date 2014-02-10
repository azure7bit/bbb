class AddPriceAttributes < ActiveRecord::Migration
  def up
  	add_column :sales_invoice_details, :price, :float
  end

  def down
  	ActiveRecord::IrreversibleMigration
  end
end
