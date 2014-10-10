class AddFieldRekening < ActiveRecord::Migration
  def up
  	add_column :rek_accounts, :tanggal_awal, :date
  	add_column :rek_accounts, :awal_debit, :float, :default => 0
  	add_column :rek_accounts, :awal_kredit, :float, :default => 0
  	add_column :rek_accounts, :mut_debit, :float, :default => 0
  	add_column :rek_accounts, :mut_kredit, :float, :default => 0
  	add_column :rek_accounts, :sisa_debit, :float, :default => 0
  	add_column :rek_accounts, :sisa_kredit, :float, :default => 0
  	add_column :rek_accounts, :rl_debit, :float, :default => 0
  	add_column :rek_accounts, :rl_kredit, :float, :default => 0
  	add_column :rek_accounts, :nrc_debit, :float, :default => 0
  	add_column :rek_accounts, :nrc_kredit, :float, :default => 0
  	add_column :rek_accounts, :posisi, :string
  	add_column :rek_accounts, :normal, :string

  	add_index :rek_accounts, :type_account_id
  end

  def down
  	ActiveRecord::IrreversibleMigration
  end
end
