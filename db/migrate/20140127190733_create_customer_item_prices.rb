class CreateCustomerItemPrices < ActiveRecord::Migration
  def change
    create_table :customer_item_prices do |t|
      t.integer :customer_item_id
      t.integer :item_id
      t.datetime :date_price
      t.float :price
      t.float :next_price
      t.timestamps
    end
  end
end