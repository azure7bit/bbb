class AddColorItem < ActiveRecord::Migration
  def change
  	add_column :items, :ci_number, :string
    add_column :items, :color, :string
    add_column :items, :is_active, :boolean, :default => true
    add_column :categories, :is_active, :boolean, :default => true
    add_column :suppliers, :is_active, :boolean, :default => true
    add_column :customers, :is_active, :boolean, :default => true
  end
end
