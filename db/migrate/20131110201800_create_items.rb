class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :code
      t.string :name
      t.integer :category_id
      t.float :retail_price
      t.integer :stock
    end
  end
end
