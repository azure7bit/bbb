class AddSupplierItemsInfo < ActiveRecord::Migration
  def up
    add_column :supplier_items, :date_price, :datetime
    add_column :supplier_items, :price, :float
    add_column :supplier_items, :next_price, :float
  end

  def down
    ActiveRecord::IrreversibleMigration
  end
end
