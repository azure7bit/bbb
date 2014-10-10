class CreateRekAccounts < ActiveRecord::Migration
  def change
    create_table :rek_accounts do |t|
      t.string :number
      t.string :name
      t.integer :type_account_id
      t.integer :parent_id
      t.timestamps
    end
  end
end