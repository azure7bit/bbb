class AddContactPerson < ActiveRecord::Migration
  def up
  	add_column :suppliers, :contact_person, :string
  end

  def down
  	remove_column :suppliers, :contact_person, :string
  end
end