class AddMinimumStock < ActiveRecord::Migration
  def up
    add_column :items, :minimum_stock, :integer
  end

  def down
    remove_column :items, :minimum_stock, :integer
  end
end
