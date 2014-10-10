class ChangeAttributeDate < ActiveRecord::Migration
  def up
  	change_column :po_receives, :transaction_date, :datetime
  end

  def down
  	change_column :po_receives, :transaction_date, :date
  end
end
