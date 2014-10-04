class CreateMixItems < ActiveRecord::Migration
  def change
    create_table :mix_items do |t|
      t.string :name
      t.integer :category_id
      t.integer :item_first
      t.integer :item_first_value
      t.integer :item_second
      t.integer :item_second_value
      t.integer :stock
      t.decimal :harga
      t.timestamps
    end
  end
end