class RemoveTransDateFromPo < ActiveRecord::Migration
  def change
    remove_column :purchase_orders, :transaction_date
  end
end
