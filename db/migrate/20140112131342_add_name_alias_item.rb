class AddNameAliasItem < ActiveRecord::Migration
  def up
  	add_column :items, :name_alias, :string
  end

  def down
  	remove_column :items, :name_alias, :string
  end
end
