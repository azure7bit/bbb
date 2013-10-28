class AddDateRegistered < ActiveRecord::Migration
  def change
    add_column :users, :date_registered, :datetime, :after => :username
  end
end
