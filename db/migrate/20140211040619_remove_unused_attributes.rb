class RemoveUnusedAttributes < ActiveRecord::Migration
  def up
  	remove_column :supplier_items, :date_price
  	remove_column :supplier_items, :price
  	remove_column :supplier_items, :next_price
  end

  def down
  	ActiveRecord::IrreversibleMigration
  end
end
