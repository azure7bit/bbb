class RollBackRemoveUnusedAttributes < ActiveRecord::Migration
  def up
    add_column :supplier_items, :date_price, :datetime
    add_column :supplier_items, :price, :float
    add_column :supplier_items, :next_price, :float
    rename_column :customer_item_prices, :customer_item_id, :customer_id
  end

  def down
    ActiveRecord::IrreversibleMigration
  end
end
