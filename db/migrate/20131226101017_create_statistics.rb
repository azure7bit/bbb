class CreateStatistics < ActiveRecord::Migration
  def change
    create_table :statistics do |t|
      t.integer :total_item, :default => 0
      t.integer :total_supplier, :default => 0
      t.integer :total_customer, :default => 0
      t.float :total_sales, :default => 0
      t.float :total_purchase, :default => 0
      t.timestamps
    end
  end
end