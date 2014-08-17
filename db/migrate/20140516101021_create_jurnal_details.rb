class CreateJurnalDetails < ActiveRecord::Migration
  def change
    create_table :jurnal_details do |t|
      t.integer :jurnal_id
      t.integer :rec_account_id
      t.integer :index_jurnal
      t.integer :pos
      t.decimal :debet
      t.decimal :kredit
      t.timestamps
    end
  end
end
