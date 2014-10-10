class CreateJurnals < ActiveRecord::Migration
  def change
    create_table :jurnals do |t|
      t.string :number
      t.date :jurnal_date
      t.text :note
      t.timestamps
    end
  end
end
