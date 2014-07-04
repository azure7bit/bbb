class CreatePoReceiveDetails < ActiveRecord::Migration
  def change
    create_table :po_receive_details do |t|
      t.integer :po_receive_id
      t.integer :qty
      t.float :price
      t.float :subtotal
      t.integer :item_id
      t.timestamps
    end
  end
end
