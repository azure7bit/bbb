class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      t.string :username
      t.string :id_card
      t.string :first_name
      t.string :last_name
      t.integer :role_id
      t.boolean :is_active
      t.string :email,              :null => false, :default => ""
      t.string :encrypted_password, :null => false, :default => ""

      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      t.datetime :remember_created_at

      t.integer  :sign_in_count, :default => 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip
      t.timestamps
    end

    add_index :users, :email,                :unique => true
    add_index :users, :reset_password_token, :unique => true
    add_index :users, :username, :unique => true
    add_index :users, :id_card, :unique => true
    add_index :users, :role_id
  end
end