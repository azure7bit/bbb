class AddTypeCurrency < ActiveRecord::Migration
  def up
  	add_column :currency_types, :boolean, :default => false
  end

  def down
  	ActiveRecord::IrreversibleMigration
  end
end
