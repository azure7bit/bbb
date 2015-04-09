class AddDbIndex < ActiveRecord::Migration
  def up
  	add_index :customer_item_prices, :customer_id
  	add_index :customer_item_prices, :item_id
  	add_index :manage_stocks, :supplier_id
  	add_index :manage_stocks, :item_id
  	add_index :po_receive_details, :po_receive_id
  	add_index :po_receive_details, :item_id
  	add_index :po_receives, :purchase_order_id
  	add_index :po_receives, :user_id
  	add_index :po_receives, :supplier_id
  	add_index :supplier_item_prices, :supplier_item_id
  	add_index :supplier_item_prices, :item_id
  end

  def down
  	ActiveRecord::IrreversibleMigration
  end
end
