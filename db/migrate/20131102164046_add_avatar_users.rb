class AddAvatarUsers < ActiveRecord::Migration
  def change
    add_column :users, :address, :string, :after => :email
    add_column :users, :phone_number, :string, :after => :address
    add_column :users, :avatar, :string
  end
end
