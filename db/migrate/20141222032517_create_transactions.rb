class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :rek_account_id
      t.decimal :saldo
      t.boolean	:currency_type
      t.string	:posisi
      t.string	:from_transaction
      t.string	:name
      t.text	:description
      t.timestamps
    end
  end
end