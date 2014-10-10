class AddPpnOption < ActiveRecord::Migration
  def up
  	add_column :supplier_items, :is_ppn, :boolean, :default => false
  end

  def down
  	remove_column :supplier_items, :is_ppn, :boolean
  end
end