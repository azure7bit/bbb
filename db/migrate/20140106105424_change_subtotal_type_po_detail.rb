class ChangeSubtotalTypePoDetail < ActiveRecord::Migration
  def up
  	change_column :purchase_order_details, :subtotal, :decimal
  end

  def down
  	change_column :purchase_order_details, :subtotal, :integer
  end
end
