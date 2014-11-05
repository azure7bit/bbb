class CreateMixItems < ActiveRecord::Migration
  def change
    create_table :mix_items do |t|
      t.integer :item_id
      t.integer :qty
      t.integer :current_id
      t.timestamps
    end

    add_column :sales_invoice_details, :order_name, :string
    add_index :mix_items, :item_id
  end
end
