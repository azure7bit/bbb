class AddPpnCharge < ActiveRecord::Migration
  def up
  	add_column :customers, :ppn_charge, :boolean
  end

  def down
  	remove_column :customers, :ppn_charge, :boolean
  end
end
