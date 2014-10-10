class AddTotalCriticalItems < ActiveRecord::Migration
  def up
  	add_column :statistics, :total_critical_items, :integer, :default => 0
  end

  def down
  	remove_column :statistics, :total_critical_items, :integer
  end
end
