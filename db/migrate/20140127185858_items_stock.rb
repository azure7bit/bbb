class ItemsStock < ActiveRecord::Migration
  def up
  	remove_column :items, :minimum_stock
    remove_column :items, :retail_price
    remove_column :supplier_items, :purchase_price
  	add_column :supplier_items, :stock, :integer, :default => 0
  	add_column :supplier_items, :date_item, :datetime
  end

  def down
    ActiveRecord::IrreversibleMigration
  end
end